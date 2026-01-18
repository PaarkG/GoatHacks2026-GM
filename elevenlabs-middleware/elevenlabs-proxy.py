from flask import Flask, request, send_file, jsonify
import requests
import io
import subprocess
import tempfile
import os
import json

app = Flask(__name__)

# Your API keys
ELEVENLABS_API_KEY = ""
GEMINI_API_KEY = ""
VOICE_ID = "21m00Tcm4TlvDq8ikWAM"  # Rachel voice

@app.route('/list_models')
def list_models():
    """Debug endpoint to see available Gemini models"""
    try:
        url = f"https://generativelanguage.googleapis.com/v1beta/models?key={GEMINI_API_KEY}"
        response = requests.get(url)
        return jsonify(response.json())
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/generate_response')
def generate_response():
    """Generate a contextual response based on game stats using Gemini"""
    try:
        # Get parameters
        relationship = request.args.get('relationship', 'friend')
        energy = float(request.args.get('energy', 100))
        hygiene = float(request.args.get('hygiene', 100))
        food = float(request.args.get('food', 100))
        rizz = float(request.args.get('rizz', 50))
        sanity = float(request.args.get('sanity', 100))
        grade_one = float(request.args.get('grade_one', 70))
        grade_two = float(request.args.get('grade_two', 70))
        grade_three = float(request.args.get('grade_three', 70))
        
        print(f"Generating response for {relationship}")
        print(f"Stats - Energy:{energy}, Hygiene:{hygiene}, Food:{food}, Rizz:{rizz}, Sanity:{sanity}")
        print(f"Grades - 1:{grade_one}, 2:{grade_two}, 3:{grade_three}")
        
        # Build the prompt for Gemini
        prompt = f"""You are simulating a conversation in a college life simulation game. The player is approaching a {relationship}. Generate a realistic two-part dialogue exchange.

Current Player Stats (0-100 scale, 0=bad, 100=good):
- Energy: {energy}
- Hygiene: {hygiene}
- Food: {food}
- Rizz (charisma): {rizz}
- Sanity: {sanity}
- Grade in Class 1: {grade_one}
- Grade in Class 2: {grade_two}
- Grade in Class 3: {grade_three}

Generate:
1. PLAYER dialogue: One sentence the player would say when initiating conversation (max 12 words). Should reflect their current state subtly.
2. NPC dialogue: The {relationship}'s response (max 15 words). React to the player's state and what they said.

Dialog Rules:
- Natural, conversational language
- Player's dialog should hint at their condition without stating stats
- NPC reacts to both what player says AND their appearance/condition
- Sound like real people talking
- Don't mention numbers or stats explicitly

Rizz Evaluation:
Evaluate how this interaction affects the player's charisma based on:
- Their hygiene, energy, sanity (appearance/demeanor)
- Their academic performance (if relevant to conversation)
- Quality of their greeting/approach

Suggest rizz change from -25 to +10:
- Bad appearance/low stats/awkward approach: -15 to -25
- Mediocre interaction: -5 to +2
- Good appearance/high stats/smooth approach: +3 to +10

Respond ONLY with valid JSON (no markdown, no extra text):
{{"player_text": "player's greeting here", "npc_text": "npc's response here", "rizz_change": 5}}

Response:"""
        
        # Generate response with Gemini using REST API
        gemini_url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key={GEMINI_API_KEY}"
        
        gemini_payload = {
            "contents": [{
                "parts": [{
                    "text": prompt
                }]
            }]
        }
        
        gemini_response = requests.post(gemini_url, json=gemini_payload)
        
        if gemini_response.status_code != 200:
            raise Exception(f"Gemini API error: {gemini_response.text}")
        
        gemini_data = gemini_response.json()
        generated_text = gemini_data['candidates'][0]['content']['parts'][0]['text'].strip()
        
        # Parse the JSON response from Gemini
        # Remove markdown code blocks if present
        generated_text = generated_text.replace('```json', '').replace('```', '').strip()
        
        try:
            response_data = json.loads(generated_text)
            player_text = response_data.get('player_text', '').strip('"').strip("'")
            npc_text = response_data.get('npc_text', '').strip('"').strip("'")
            rizz_change = response_data.get('rizz_change', 0)
            
            # Clamp rizz_change to valid range
            rizz_change = max(-25, min(10, rizz_change))
            
            print(f"Generated Player: {player_text}")
            print(f"Generated NPC: {npc_text}")
            print(f"Rizz change: {rizz_change:+d}")
            
            return jsonify({
                "player_text": player_text,
                "npc_text": npc_text,
                "rizz_change": rizz_change,
                "success": True
            })
            
        except json.JSONDecodeError as e:
            print(f"Failed to parse JSON: {generated_text}")
            # Fallback
            return jsonify({
                "player_text": "Hey, how's it going?",
                "npc_text": "Good to see you!",
                "rizz_change": 0,
                "success": True
            })
        
    except Exception as e:
        error_msg = f"Gemini Error: {str(e)}"
        print(error_msg)
        import traceback
        traceback.print_exc()
        return jsonify({
            "text": "Hey, how's it going?",
            "success": False,
            "error": error_msg
        }), 500

@app.route('/tts')
def text_to_speech():
    """Convert text to speech using ElevenLabs and return OGG audio"""
    try:
        # Get text and voice_id from URL parameters
        text = request.args.get('text', 'Hello world')
        voice_id = request.args.get('voice_id', VOICE_ID)  # Use default if not provided
        
        print(f"Generating TTS for: {text}")
        print(f"Using voice: {voice_id}")
        
        # Call ElevenLabs API
        url = f"https://api.elevenlabs.io/v1/text-to-speech/{voice_id}"
        
        headers = {
            "xi-api-key": ELEVENLABS_API_KEY,
            "Content-Type": "application/json"
        }
        
        data = {
            "text": text,
            "model_id": "eleven_turbo_v2_5",
            "voice_settings": {
                "stability": 0.5,
                "similarity_boost": 0.75
            }
        }
        
        response = requests.post(url, json=data, headers=headers)
        
        if response.status_code == 200:
            print(f"ElevenLabs success! MP3 size: {len(response.content)} bytes")
            
            # Create temporary files for conversion
            with tempfile.NamedTemporaryFile(delete=False, suffix='.mp3') as mp3_file:
                mp3_file.write(response.content)
                mp3_path = mp3_file.name
            
            ogg_path = mp3_path.replace('.mp3', '.ogg')
            
            try:
                # Convert MP3 to OGG using ffmpeg
                print("Converting to OGG...")
                subprocess.run([
                    'ffmpeg', '-i', mp3_path,
                    '-c:a', 'libvorbis',
                    '-q:a', '4',
                    '-y',
                    ogg_path
                ], check=True, capture_output=True)
                
                # Read the OGG file
                with open(ogg_path, 'rb') as f:
                    ogg_data = f.read()
                
                print(f"Conversion complete! OGG size: {len(ogg_data)} bytes")
                
                return send_file(
                    io.BytesIO(ogg_data),
                    mimetype='audio/ogg',
                    as_attachment=True,
                    download_name='speech.ogg'
                )
                
            finally:
                if os.path.exists(mp3_path):
                    os.remove(mp3_path)
                if os.path.exists(ogg_path):
                    os.remove(ogg_path)
        else:
            error_msg = f"ElevenLabs Error {response.status_code}: {response.text}"
            print(error_msg)
            return error_msg, 500
            
    except Exception as e:
        error_msg = f"TTS Error: {str(e)}"
        print(error_msg)
        import traceback
        traceback.print_exc()
        return error_msg, 500

if __name__ == '__main__':
    print("=" * 60)
    print("AI-Powered Game Dialog Server")
    print("=" * 60)
    print("Endpoints:")
    print("  /generate_response - Generate contextual dialog with Gemini")
    print("  /tts - Convert text to speech with ElevenLabs")
    print("")
    print("Requirements: ffmpeg in PATH, API keys configured")
    print("=" * 60)
    app.run(host='localhost', port=5000, debug=True)
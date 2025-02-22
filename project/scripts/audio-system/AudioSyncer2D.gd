class_name AudioSyncer2D
extends AudioStreamPlayer2D

# Constants.
const UNKNOWN_AUDIO: String = "None";
const BGM_AUDIO: String = "BGM";
const SFX_AUDIO: String = "SFX";

@export_enum(UNKNOWN_AUDIO, BGM_AUDIO, SFX_AUDIO)
var _audio_type: String = UNKNOWN_AUDIO;

# Runtime variable data.
var _audio_manager: AudioManager = null;
var _config: AudioConfigData = null;

func _enter_tree() -> void:
	_audio_manager = audio_manager as AudioManager;
	_audio_manager.register_audio_syncer(self);
	_config = _audio_manager.get_config();

func _exit_tree() -> void:
	_audio_manager.unregister_audio_syncer(self);

func set_audio_volume(v: float) -> void:
	volume_db = v;

func get_audio_type() -> int:
	match _audio_type:
		BGM_AUDIO: return AudioManager.BGM_AUDIO;
		SFX_AUDIO: return AudioManager.SFX_AUDIO;
	return AudioManager.UNKNOWN_AUDIO;

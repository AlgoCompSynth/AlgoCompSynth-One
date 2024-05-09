# https://chrisalbon.com/code/deep_learning/pytorch/basics/check_if_pytorch_is_using_gpu/

import torch
print("torch import successful")
import torchaudio
print("torchaudio import successful")
print("torchaudio backends:", torchaudio.list_audio_backends())
print("")

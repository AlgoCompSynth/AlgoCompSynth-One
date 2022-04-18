# https://chrisalbon.com/code/deep_learning/pytorch/basics/check_if_pytorch_is_using_gpu/

import torch
print("torch import successful")
print("CUDA device count:", torch.cuda.device_count())
print("current CUDA device:", torch.cuda.current_device())
print("CUDA device name:", torch.cuda.get_device_name(torch.cuda.current_device()))
print("CUDA is available:", torch.cuda.is_available())
print("")
import torchaudio
print("torchaudio import successful")

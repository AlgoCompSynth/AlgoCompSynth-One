#! /usr/bin/env python3

# https://chrisalbon.com/code/deep_learning/pytorch/basics/check_if_pytorch_is_using_gpu/
# https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-10-now-available/72048

import torch
print("torch version", torch.__version__)
print('CUDA available: ' + str(torch.cuda.is_available()))
print('cuDNN version: ' + str(torch.backends.cudnn.version()))
print("CUDA device count:", torch.cuda.device_count())

print("")
import torchvision
print("torchvision import successful")

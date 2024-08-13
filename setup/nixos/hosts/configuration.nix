{ config, lib, ... }:
{
  # amd cpu
  hardware.cpu.amdupdateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # pstate - 处理器的性能状态，涉及处理器的频率，电压和功效的管理
  

}
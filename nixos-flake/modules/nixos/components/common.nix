{ pkgs, ...}: {


  # Enable 32bits support applications
  ## nixpkg 24.04
  #hardware.opengl.driSupport32bit = true;

  ## nixpkg-unstable
  hardware.graphics.enable32Bit = true;

}

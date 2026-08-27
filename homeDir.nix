{ username, ... }: {
  # Locked custom folder topography mapping to user home space
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "/home/${username}/dsk";
    documents = "/home/${username}/spire";
    download = "/home/${username}/dump";
    pictures = "/home/${username}/content/peekz";
    music = "/home/${username}/content/tunez";
    videos = "/home/${username}/content/veedz";
  };
}

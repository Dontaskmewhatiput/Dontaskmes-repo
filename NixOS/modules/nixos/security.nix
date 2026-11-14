{ ... }: 
{
  security.pam.services= {
      sudo.nodelay = true;
      su.nodelay = true;
      login.nodelay = true;
      sddm.nodelay = true;
      sudo.allowNullPassword = false;
  };
}

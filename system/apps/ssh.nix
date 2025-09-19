{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    # 禁止 root 远程登录（推荐）
    settings.PermitRootLogin = "no";  # 可选 "yes" / "no" / "prohibit-password"

    # 禁止密码登录，只允许密钥
    settings.PasswordAuthentication = false;

    # 开启公钥认证
    # authorizedKeysFiles = [ ".ssh/authorized_keys" ];
  };
  users.users.me.openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD2lLwM6D5IgruJ0Lb45/IdP4OJ2BuyqRj6I6eBMi/uQSg3A+WtX7a2y9h9xOHPMc+GMvqvGLQHXabLuaO7Vlo+jk9PcMgbzPsCf0SU/0AQBt1nXSzA3JXY2FFTlFPp2bJwBPkxjexFIX6OYVlzLz1/n+Rdk9N8XF+/kNWvuCEG0Mg8E/C/lPV+NkCIVapFxNSkYP6z6RS+nsORJHCzAlOiozrzRu9vsQEFh5jDPGicwi322kXXnx93EcmwWLSOP7iUBOx4ciFtSCBSnrAnPEg/1/Jaw99jXaIZJMX1+j7/Q8ZJPsGoDXg3I4vrlstXdX2lTQoPgsXjh7SYr+/dS7tQ/GOZUlIINXze1faVZi/9xKHP9Y9tRzunWn5f6HEMB56Vfi9o773eVsLBmzaVqjQFymcjeI1FMw6qW7K6HdpVqUMyCXiWn8zuRPPrRe/msgdo0r15KtfmSINhPnH3aNaibDjWT5CUQNRFzmGxKzidRVKFzVLIR6Kr8bK7fJmv8Rk= me@me.me"
  ];
  /*
  services.openvscode-server = {
    enable = true;
    host = "0.0.0.0";
    user = "me";
  };*/
}

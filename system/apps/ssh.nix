{ config, lib, ...}:
{
  config = lib.mkIf config.mine.machine.asServer.enable { # only enable when this machine could be a server
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
        # nixple
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKq7V03NNItRGotgIeNq6dGoupC7iA5vaMtuPzdYGrCl"
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCSuNrpr2B5gv6lMtp/YAB+eYEKsmVhhhOGqI+Xy8mrOV8dRbzq4XdLuJHNeeWa7iJfE3i4exxv2uGBlcT1ZflE2EnToEn5RJ3qew7njwjm5JI5cCrlVWKHH7BasrRce814kh+uPNavbS1L6Zggl+MIvOIurb/GgdzGmvR1Kix0hiYa1K1EIIBCPcT51mp3z/qPBMKNY1yCGTVLSjHp3TsrRgggjOU9CdwZW88+thA9M8vZkjGb6MZOfH76ezgAdtw43XcFJzb3ypLgzasZz1FUYdi8+CTlTD5SwJFefG1ws70dh4Rsl515ZcdKs9oqSM1F3r13NnJjrsbpt8eQx8BMjBwVR7p79qy39DzRiOLY8wYlwOOzsS9nr3biSGcaYAik6MAqvjMw1TFKcV29RfR397Kj7JWeYstWBJiaGnUN5vWH3+mZ420c4Cu5ZVSv61CafUQxMIEjhcU1PekPK0fY96KghjVAp2am1XdJ7bPF8b1qvJMDe8kAqyYDJ5r27LM= ruibama@HOME-MacBook-Air.local"
        # macbook macos
    ];
    /*
    services.openvscode-server = {
      enable = true;
      host = "0.0.0.0";
      user = "me";
    };*/
  };
}

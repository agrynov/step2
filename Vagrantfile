Vagrant.configure("2") do |config|
  # Общие настройки для обеих виртуальных машин
  config.vm.box = "bento/ubuntu-22.04"


  # Виртуальная машина для Jenkins-сервера
  config.vm.define "jenkins-server" do |server|
    server.vm.hostname = "jenkins-server"
    server.vm.network "private_network", ip: "192.168.56.10"
    server.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 2
    end
    server.vm.provision "shell", inline: <<-SHELL
      # Обновление списка пакетов
      sudo apt-get update
      # Установка Java OpenJDK 11
      sudo apt-get install -y openjdk-17-jdk

      # Добавление ключа Jenkins
      curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
        /usr/share/keyrings/jenkins-keyring.asc > /dev/null

      # Добавление репозитория Jenkins LTS
      echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
        https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null

      # Обновление списка пакетов после добавления репозитория Jenkins
      sudo apt-get update

      # Установка Jenkins
      sudo apt-get install -y jenkins

      # Запуск и включение Jenkins при старте системы
      sudo systemctl enable --now jenkins

      # Установка Docker
      sudo apt-get install -y docker.io
      curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
      sudo apt-get install -y nodejs
      # Добавление пользователя Jenkins в группу Docker
      sudo usermod -aG docker jenkins

      # Перезапуск Jenkins для применения изменений
      sudo systemctl restart jenkins
    SHELL
  end

  # Виртуальная машина для Jenkins-агента
  config.vm.define "jenkins-agent" do |agent|
    agent.vm.hostname = "jenkins-agent"
    agent.vm.network "private_network", ip: "192.168.56.11"
    agent.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
      vb.cpus = 2
    end
    agent.vm.provision "shell", inline: <<-SHELL
      # Обновление списка пакетов
      sudo apt-get update

      # Установка Java OpenJDK 11
      sudo apt-get install -y openjdk-17-jdk

      # Установка Docker
      sudo apt-get install -y docker.io

      # Добавление пользователя vagrant в группу Docker
      sudo usermod -aG docker vagrant

      # Перезапуск Docker для применения изменений
      sudo systemctl restart docker
    SHELL
  end

end

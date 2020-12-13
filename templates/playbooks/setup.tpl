---
- hosts: ${host}
  user: root
  gather_facts: false

  tasks:

    - name: wait for ssh connection
      wait_for_connection:
        delay: 60
        timeout: 300

    - name : add a user
      user: 
        name: "${new_user_name}"
        password: "{{ '${new_user_password}' | password_hash('sha512') }}"
        shell: "${shell}"
        state: "present"
        groups: "sudo"

    - name: make a .ssh directory
      file: 
        path: "~${new_user_name}/.ssh"
        state: "directory"
        owner: "${new_user_name}"
        group: "${new_user_name}"
        mode: 0700

    - name: copy a public key to an authorized_keyss
      copy: 
        dest: "~${new_user_name}/.ssh/authorized_keys"
        content: "${new_user_public_key}"
        mode: 0600
        owner: "${new_user_name}"
        group: "${new_user_name}"

    - name: change sshd_config for changing a port number for ssh
      lineinfile:
        dest: "/etc/ssh/sshd_config"
        regexp: "^Port"
        insertafter: "^#Port"
        line: Port "${port}"

    - name: change sshd_config for disabling password authentication
      lineinfile:
        dest: "/etc/ssh/sshd_config"
        regexp: "^PasswordAuthentication"
        insertafter: "^#PasswordAuthentication"
        line: "PasswordAuthentication no"
      notify:
        - restart sshd

    - name: change sshd_config for disabling permit root login
      lineinfile:
        dest: "/etc/ssh/sshd_config" 
        regexp: "^PermitRootLogin"
        line: "PermitRootLogin no"
        state: "present"
      notify:
        - restart sshd

    - name: change iptables for accepting new ssh connections
      iptables:
        chain: "INPUT"
        protocol: "tcp"
        destination_port: "${port}"
        ctstate: "NEW"
        syn: "match"
        jump: "ACCEPT"
        comment: "Accept new SSH connections."

    - name: logout from a root user
      meta: reset_connection

  handlers:

    - name: restart sshd
      service:
        name: "sshd"
        state: "restarted"
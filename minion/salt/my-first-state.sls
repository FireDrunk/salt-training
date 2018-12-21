Set an example file in Vagrant:
  file.managed:
    - name: /testfile
    - contents: "Hello from Salt in Vagrant!"

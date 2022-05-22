Library
=======

Library consists of custom Ansible modules, that can be used with any role or playbook in this repository.

Using modules more systematic way of doing certain tasks.
For example, we provide ``jenkins_node`` module, which allows to configure Jenkins node (slave) using API.
This task could be done using Ansible's built-in ``shell`` module and ``curl`` command line tool.

In this case, module is advantageous, because it provides more control over catching exceptions or determining the "failed" and "changed" results.

Library files are placed in is in ``./library``. See below for the module documentation.

.. automodule:: jenkins_csrf_token
   :members: main

.. automodule:: jenkins_node
   :members: main

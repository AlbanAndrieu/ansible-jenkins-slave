Roles & Playbooks
=================

TODO - it should be the most exhaustive section.

These playbooks deploy a very basic workstation with all the required tool needed for a developer or buildmaster to work on NABLA.

Then run the playbook, like this::

	ansible-playbook -i hosts -c local -v workstation.yml -vvvv

When the playbook run completes, you should be able to work on any NABLA project, on the target machines.

This is a very simple playbook and could serve as a starting point for more
complex projects.

Use cases
---------

Minimal Jenkins Slave
~~~~~~~~~~~~~~~~~~~~~

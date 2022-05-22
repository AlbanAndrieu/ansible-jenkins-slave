Quality & Testing
=================

Commit Hook
-----------

Can be run using ``pre-commit`` tool (http://pre-commit.com/):

.. code-block:: bash

   pre-commit install

First time run

.. code-block:: bash

   git checkout this repo hooks/

THEN

.. code-block:: bash

   cp hooks/* .git/hooks/

OR

.. code-block:: bash

   rm -Rf ./.git/hooks/ && ln -s ../hooks ./.git/hooks

.. code-block:: bash

   pre-commit run --all-files

   SKIP=ansible-lint git commit -am 'Add key'
   git commit -am 'Add key' --no-verify

Generate sphinx documentation
-----------------------------

.. code-block:: bash

   sphinx-build -b html ./docs docs/_build/

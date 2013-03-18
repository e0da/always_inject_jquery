Always Inject jQuery
====================

Always inject jQuery into every page without clobbering any existing libraries.

How It Works
------------

The latest v1 release of jQuery is injected into the page from Google CDNs. If $
or jQuery are already defined on the page, they aren't broken. A badge on the
app icon shows the variable name by which the injected jQuery can be accessed in
the console.

Copyright and License
---------------------

Copyright © 2012 by Justin Force and licensed under the MIT license.

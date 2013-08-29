noreferrer.js
=============

Cross-browser support for HTML5's noreferrer link type.

HTML5 defines a new link type called "noreferrer" which may be used to
annotate a hyperlink to indicate that a Referer (sic) header should
not be sent when following the link.

This is particularly useful when you want to put hyperlinks to
external resources on your private site which URL should not be
leaked.

At the time of writing, WebKit-based browsers such as Safari,
MobileSafari, Chrome and Opera 15+ already support this feature but
IE, Firefox and Opera 12- do not.

This package contains two variants of JavaScript implementations that
add the "noreferrer" link type to those browsers without native
support.

Requirements
------------

* noreferrer.js depends on:

    * prototype.js 1.6 or later

* jquery.noreferrer.js depends on:

    * jQuery 1.2 or later

Compatibility
-------------

* Chrome, Safari, MobileSafari, Opera 15+ and other WebKit-based
  browsers

    These have native support for noreferrer links, so noreferrer.js
    does nothing.

* IE 6+

    noreferrer.js uses a simple meta refresh technique to suppress
    Referer, plus disables opening a new window with middle clicking.

* Opera 12-

    There seems to be no way to prevent the browser from sending a
    Referer header, so noreferrer.js replaces all noreferrer links
    with those using Google's redirector.

* Firefox and other browsers

    noreferrer.js uses a data URI technique to suppress Referer, plus
    disables opening a new window with middle clicking.

Usage
-----

Just include either noreferrer.js or jquery.noreferrer.js, depending
on the JavaScript framework you are using, at the end of the <head>
part of an HTML document, and an onload event handler is attached to
enable the noreferrer trick for each link with the noreferrer rel
type.

    <script type='text/javascript' src='noreferrer.js'></script>

It does not deal with dynamically created links at the moment.

History
-------

* v0.1.3

   * Bundled jquery.noreferrer.js.

   * Make small optimizations.

Author
------

Akinori MUSHA <<knu@idaemons.org>>

License
-------

All files except for ones under "vendor" are licensed under a 2-clause
BSD license.

See LICENSE for the copyright information and license terms.

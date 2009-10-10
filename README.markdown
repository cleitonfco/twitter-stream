Twitter Stream
==============

* [http://github.com/cleitonfco/twitter-stream](http://github.com/cleitonfco/twitter-stream)

DESCRIPTION
------------

Twitter Stream allows to track tweets about events and hashtags in real time. 
It is a small application powered by ruby with [Sinatra](http://www.sinatrarb.com) framework.

Twitter Stream is not affiliated with [Twitter, Inc](http://twitter.com).

PRE-REQUISITES
--------------

Twitter Stream makes use of a handful of ruby gems, it is:

**Sinatra**

    sudo gem install sinatra

**HAML**

    sudo gem install haml

**JSON**

    sudo gem install json

You may want to use the **Thin** as web server, make sure you have it installed, however, install it:

    sudo gem install thin

USAGE
-----

Run `init.rb` to create database and tables:

    ruby init.rb

Change the _term_ variable in file `search.rb` and run to capture tweets about a keyword or hashtag (_term_):

    ruby search.rb

Execute the thin server (or other) to start application:

    thin start -p PORT -R config.ru

Where PORT is the URL number port. to use another environment add the command '-e ENVIRONMENT', 
where ENVIRONMENT can be `:test`, `:development` or `:production`.

CONTRIBUTERS
------------

- Cleiton Francisco [http://cleitonfco.com.br](http://cleitonfco.com.br) and [http://twitter.com/cleitonfco](http://twitter.com/cleitonfco)
- Cairo Noleto [http://caironoleto.com](http://caironoleto.com) and [http://twitter.com/caironoleto](http://twitter.com/caironoleto)
- Cyrus Cavalcante [http://twitter.com/cyruscavalcante](http://twitter.com/cyruscavalcante)
- Weldys Santos [http://twitter.com/weldyss](http://twitter.com/weldyss)

LICENSE
-------

Copyright (c) 2009 [Cleiton Francisco](http://cleitonfco.com.br)

Twitter Stream is released under the MIT License. See the LICENSE file for details.


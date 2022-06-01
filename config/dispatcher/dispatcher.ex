defmodule Dispatcher do

  use Matcher

  define_accept_types [
    any: [ "*/*" ],
    #json: [ "application/json", "application/vnd.api+json" ]
  ]

  match "/yasgui", _ do
    forward conn, [], "http://yasgui/"
  end

  match "/sparql/*path", _ do
    forward conn, path, "http://triplestore:8890/sparql"
    #forward conn, path, "http://db:8890/sparql"
  end


  # can also be done using
  # @any %{ accept %{ any: true }}
  # match "/simple-js", @any do

  match "/simple-js", %{ accept: [:any] } do
    forward conn, [], "http://simple-js/"
  end

  match "/addresses/*path", _ do
    #IO.inspect( path, label: "path for /addresses" )
    forward conn, path, "http://resources/addresses/"
  end

  match "/contactpoints/*path", _ do
    #IO.inspect( conn, label: "conn for /themes" )
    forward conn, path, "http://resources/contactpoints/"
  end

  match "/cities/*path", _ do
    #IO.inspect( conn, label: "conn for /themes" )
    forward conn, path, "http://resources/cities/"
  end

  # for none existing routes
  match "/_*", %{ last_call: true, accept: %{ json: true } } do
    send_resp( conn, 404, "Route not found. See config/dispatcher.ex" )
  end

end

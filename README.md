# training-map-stack

This stack is built in order to learn how the [semantic.work](https://semantic.works/) framework needs to be used.

It uses a RDF/SPARQL database of contactpoints in flanders in order to filter and display them on a map.

You can find the frontend part [here](https://github.com/jsz4n/frontend-training-map)

In the utils folder you will find a python script converting a [csv file](https://github.com/spatie/belgian-cities-geocoded/) of belgium cities coordinates
into a ttl file containing triples



I deployed and configured various services :

- mu-identifier and mu-authorization which manage cookies and read-write rights on virtuoso
- yasgui used to query the triplestore
- mu-migration which I used in order to add uuids to addreses then add the generated ttl file (with coordinates) and then link the cities to existing data into virtuoso
- mu-dispatcher which I configured in order to pass queries to appropriate service
- virtuoso (triplestore)
- mu-cl-ressource in which I configured the API using the [domain.lisp](https://github.com/jsz4n/app-training-map/blob/main/config/resources/domain.lisp) file


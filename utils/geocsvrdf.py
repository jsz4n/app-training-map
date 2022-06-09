import csv,sys
from rdflib import URIRef, BNode, Literal, Namespace
from rdflib.namespace import FOAF, DCTERMS, XSD, RDF, SDO
from rdflib import Graph



filename = "./belgian-cities-geocoded.csv"
DBPO = Namespace("http://dbpedia.org/ontology/")
DBP = Namespace("https://dbpedia.org/property/")
JSZ4N = Namespace("http://sem.jsz4n.dev/belgium/")
MU = Namespace("http://mu.semte.ch/vocabularies/core/")
NS2 = Namespace("https://data.vlaanderen.be/ns/adres#")
LOCN = Namespace("http://www.w3.org/ns/locn#")
GEO = Namespace("http://www.w3.org/2003/01/geo/wgs84_pos#")
rdf_cols = [DBPO["postalCode"], NS2["gemeentenaam"], GEO["lat"], GEO["long"], LOCN["thoroughfare"]]#, GEO["geometry"]]
#cols_type = [XSD.int, XSD.string, XSD.float, XSD.float, XSD.string, XSD.string]
types = [int, str, float, float, str, str]


g= Graph()
g.bind("locn", LOCN)
g.bind("ns2", NS2)
g.bind("mu", MU)
g.bind("dbpo", DBPO)
g.bind("dbp", DBP)
g.bind("geo", GEO)
g.bind("rdf", RDF)
g.bind("jsz4n", JSZ4N)

file = csv.reader(open(filename, "r"))

list_ville_multi=[]
cols = None #['postal', 'name', 'lat', 'lng', 'province']
i=True
for row in file:
    if file.line_num==1:
        cols = list(row)
    else:
        uid=row[cols.index("name")].replace(" ","_")+"_"+row[cols.index("postal")]
        e = JSZ4N[row[cols.index("name")].replace(" ","_")+"_"+row[cols.index("postal")]]
        g.add((e, RDF.type, DBPO["City"]))
        g.add((e, MU["uuid"], Literal(uid)))
        for i,(v,p) in enumerate(zip(row, rdf_cols[:-1])):
            if "," not in v:
                g.add((e, p, Literal(types[i](v))))
            else:
                list_ville_multi.append(row[1])
                for val in v.split(","):
                    g.add((e, p, Literal(types[i](val))))#, datatype=cols_type[i])))

print(g.serialize(format="ttl"))
with open("belgium-cities.ttl", "w") as wfile:
    wfile.write(g.serialize(format="ttl"))


print(list_ville_multi)


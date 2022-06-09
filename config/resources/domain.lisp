(in-package :mu-cl-resources)


(define-resource contactPoint ()
        :class (s-prefix "schema:ContactPoint")
        :properties `(
                      (:mail :string ,(s-prefix "schema:email"))
                      (:phone :string ,(s-prefix "schema:telephone"))
                     )
        :has-one  `(
                     (address :via ,(s-prefix "locn:address") :as "address")
                   )
        :features '(include-uri)
        :on-path "contactpoints")

(define-resource address ()
        :class (s-prefix "locn:Address")
        :properties `(
                      (:city :string ,(s-prefix "ns2:gemeentenaam"))
                      (:addr :string ,(s-prefix "locn:fullAddress"))
                     )
        :has-one `(
                  (city :via ,(s-prefix "dbpo:City") :as "citydetails")
                 )
        :has-many  `(
                     (contactPoint :via ,(s-prefix "locn:address")
                                   :inverse t
                                   :as "contactpoints")
                   )
        :features '(include-uri)
        :on-path "addresses")

(define-resource city ()
        :class (s-prefix "dbpo:City")
        :properties `(
                      (:name :string ,(s-prefix "ns2:gemeentenaam"))
                      (:postcode :string ,(s-prefix "dbpo:postalCode"))
                      (:lat :string ,(s-prefix "w3cgeo:lat"))
                      (:long :string ,(s-prefix "w3cgeo:long"))
                     )
        :has-many  `(
                     (address :via ,(s-prefix "locn:address")
                                   :inverse t
                                   :as "addresses")
                   )
        :features '(include-uri)
        :on-path "cities")


(run-validations)

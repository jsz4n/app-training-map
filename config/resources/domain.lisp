(in-package :mu-cl-resources)


(define-resource contactPoint ()
        :class (s-prefix "schema:ContactPoint")
        :properties `(
                      (:uuid :string ,(s-prefix "mu:uuid"))
                      (:mail :string ,(s-prefix "schema:email"))
                      (:phone :string ,(s-prefix "schema:telephone"))
                      ;(:address :url ,(s-prefix "locn:address") ) ;:required)
                     )
        :has-one  `(
                     (address :via ,(s-prefix "locn:address") :as "address")
                    ;(address :via ,(s-prefix "locn:Address") :inverse t  :as "address")
        ;            ;(city :via ,(s-prefix "ns2:gemeentenaam") :as "city")
                   )
        :on-path "contactpoints")

(define-resource address ()
        :class (s-prefix "locn:Address")
        :properties `(
                      (:city :string ,(s-prefix "ns2:gemeentenaam"))
                      (:addr :string ,(s-prefix "locn:fullAddress"))
                     )
       ;has-one `(
       ;          (city :via ,(s-prefix "ns2:gemeentenaam") as "city")
       ;         )
        ;:has-many `(
                   ;:inverse t
                   ;(contactPoint :via ,(s-prefix "schema:ContactPoint")
                   ;                 :as "contactpoint")
                   ;)
        :on-path "addresses")
(define-resource city ()
        :class (s-prefix "dbpo:City")
        :properties `(
                      (:name :string ,(s-prefix "ns2:gemeentenaam"))
                      (:postCode :string ,(s-prefix "dbpo:postCode"))
                      (:lat :string ,(s-prefix "w3cgeo:lat"))
                      (:long :string ,(s-prefix "w3cgeo:long"))
                     )
        :on-path "cities")



; :resource-base (s-url "http://triplestore:8890/DAV")
;;;;; product groups

;; Examples resources

;; (define-resource taxonomy ()
;;   :class (s-prefix "mt:Taxonomy")
;;   :properties `((:name :string ,(s-prefix "mt:name"))
;;                 (:description :string ,(s-prefix "dc:description")))
;;   :resource-base (s-url "http://mapping-tool.sem.tenforce.com/taxonomies/")
;;   :has-many `((topic :via ,(s-prefix "mt:taxonomyTopic")
;;                      :as "topics"))
;;   :on-path "taxonomies")

;; (define-resource topic ()
;;   :class (s-prefix "mt:CursoryTopic")
;;   :properties `((:name :string ,(s-prefix "mt:name"))
;;                 (:description :string ,(s-prefix "dc:description")))
;;   :resource-base (s-url "http://mapping-tool.sem.tenforce.com/topics/")
;;   :has-many `((topic :via ,(s-prefix "mt:topic")
;;                      :as "topics")
;;               (mapping :via ,(s-prefix "mt:mapping")
;;                        :as "mappings"))
;;   :has-one `((taxonomy :via ,(s-prefix "mt:taxonomyTopic")
;;                        :inverse t
;;                        :as "taxonomy"))
;;   :on-path "topics")

;; (define-resource mapping ()
;;   :class (s-prefix "mt:Mapping")
;;   :has-many `((topic :via ,(s-prefix "mt:maps")
;;                      :as "topics"))
;;   :resource-base (s-url "http://mapping-tool.sem.tenforce.com/mappings/")
;;   :on-path "mappings")
              
;; (define-resource page ()
;;   :class (s-url "http://mu.semte.ch/vocabulary/cms/Page")
;;   :resource-base (s-url "http://mu.semte.ch/cms/resources/pages/")
;;   :properties `((:title :string ,(s-prefix "dcterms:title"))
;;                 (:content :string ,(s-prefix "cms:pageContent")))
;;   :on-path "pages")

;; (around (:show page) (&rest args)
;;   (break "This is page showing with ~A" args)
;;   (let ((response (yield)))
;;     (break "The response should be ~A" (jsown:to-json response))
;;     (jsown:new-js ("ok" t))))

;; (after (:show page) (&rest args)
;;   (declare (ignore args))
;;   (jsown:new-js ("ok" :false)))


;(read-domain-file "domain.json") ;; no domain.lisp, then load domain.json

(run-validations)
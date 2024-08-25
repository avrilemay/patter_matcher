; Nom ......... : PM_11.lisp
; Rôle ........ : pattern matcher en lisp
; Auteur ...... : Avrile Floro 
; Version ..... : V0.1 du 14/12/23
; Licence ..... : réalisé dans le cadre du cours d'Algo 1
; Usage : lisp puis (load "PM_11.lisp") puis (Eliza patterns)

(load "PM_11_data.lisp")
; sépération du fichiers pour les données 

; NAME : Eliza  > fonction principale du pattern matcher 
; ARGS :  patterns
; USAGES : (Eliza patterns)
; GLOBALS : Variables, Resultats, patterns 
; CALL : answer, read-input, match 
; USER : top level 

(defun Eliza (patterns)
  (loop
    (setq Variables nil) ; réinitialisation de Variables
    (setq Resultats nil) ; réinitilisation de résultats
    (princ "Utilisateur: "); ajout d'un saut de ligne 
    (or (answer (cdr (assoc (read-input) patterns :test #'match))) 
      (return))
    (terpri)
    (terpri) ) )

; NAME : read-input ; lit ligne, divise en mots, convertit mots en symb
; ARGS :  none
; USAGES : (read-input) > bonjour au revoir > (bonjour au revoir)
; GLOBALS : none
; CALL : split-by-one-space 
; USER : Eliza

(defun read-input ()
  (mapcar #'intern (split-by-one-space (read-line)))) 
    ; séparation mots aux espaces, transformation en symbole et ajout lst


; NAME : split-by-one-space > divise une str en mots grâce aux espaces
; ARGS :  string
; USAGES : (split-by-one-space) > (split-by-one-space "un essai") ("un" "essai")
; GLOBALS : none
; CALL : none
; USER : read-input
; SOURCE : https://lispcookbook.github.io/cl-cookbook/strings.html

* (defun split-by-one-space (string) 
    (loop for i = 0 then (1+ j)
      as j = (position #\Space string :start i)
      collect (subseq string i j)
      while j ) )

; NAME : match > associe les entrées et les patrons 
; ARGS :  input-form, pattern 
; GLOBALS : none
; CALL : $ et appartient (via apply)
; USER : Eliza

(defun match (input-form pattern)
  ;(print (list 'input-form input-form 'pattern pattern))
    (cond
      ((and (not input-form) (not pattern))) ; entrée & patron finis : réussite

      ((and (not input-form) (eq (car pattern) '*)) ; entrée finie et patron = *
        (not (cdr pattern)) )  ; vérifie si patron fini après '*'

      ((not input-form) nil) ; entrée finie mais pas patron > nil 

      ((not pattern) nil) ; patron vide mais pas entrée > nil 

      ((consp (car pattern)) ; si le 1er élt est un cons (une liste non vide)
        (cond
            ((and ; c'est ($) suivi de quelque chose d'autre dans la lst ($ A __)
                (and (> (list-length (car pattern)) 1) (eq (caar pattern) '$))
                ; applique la fonction $ et passe les arguments
                (apply (caar pattern) (cons (car input-form) (cdar pattern)))
                ; on continue
                (match (cdr input-form) (cdr pattern)) ) ) 

            ((and ; quand c'est juste ($) 
                (and (= (list-length (car pattern)) 1) (eq (caar pattern) '$)) ; longueur liste 1 et $
                (put 'Variables 'joker (car input-form)) ; stocke dans variable l'entrée associée à $
                (match (cdr input-form) (cdr pattern)) ) )
                
            ((and ; quand c'est la fonction appartient 
                (eq (caar pattern) 'appartient)
                ($ (car input-form) (cadar pattern)) ; on appelle la fonction $ 
                (apply (caar pattern) (cons (car input-form) (cddar pattern)))
                ; on continue
                (match (cdr input-form) (cdr pattern)) ) )) )   

      ((eq (car pattern) '*) ; si patron commence par *
        (or (match input-form (cdr pattern)) ; OU
          ; le mot suivant du patron est le 1er mot de l'entrée
          (match (cdr input-form) pattern) ) )
            ; on continue en gardant l'étoile 

      ((eql (car input-form) (car pattern)) ; 1er élmt patron = 1er élmt entrée
        (match (cdr input-form) (cdr pattern)) ) ) ) ; on continue avec l'élt suivant


; NAME : put ; met des valeurs dans les propriétés 
; ARGS :  symbole, attribut, valeur
; USAGES : (put 'Variables 'joker (car input-form))
; GLOBALS : Variables
; CALL : none 
; USER : match, $  

(defun put (symbole attribut valeur) (setf (get symbole attribut) valeur) valeur)


; NAME : $ ; applique les tests à input-word et màj de Variables | si non nil 
; ARGS :  input-word variable &optional test
; GLOBALS : Variables
; CALL : none 
; USER : match

(defun $ (input-word variable &optional test) 
  (and
    (or (not test) (apply test (list input-word)))
      ; si test n'est pas nil, on l'applique à input-word 
    (or (not variable) (put 'Variables variable input-word)) ) ) 
     ; si variable n'est pas nil, on màj Variables 


; NAME : answer > gestion réponse utilisateur 
; ARGS :  output-pattern
; GLOBALS : Resultats
; CALL : print-output, imprimer-lisste  
; USER : Eliza

(defun answer (output-pattern)
  (cond
    ((and ; si correspondance 
        (print-output output-pattern)  ; appel print-output
        (setq Resultats (reverse Resultats))  ; inversion de la liste résultats obtenue
        (push "Fabien Roussel:" Resultats)
        (imprimer-liste Resultats) ) ) 
    
    (t (setq Resultats (reverse Resultats)) ; pour terminer la conversation
      (push "Fabien Roussel:" Resultats)
      (imprimer-liste Resultats)
      nil ) ) )  ; impression du nil pour sortir


; NAME : imprimer-liste > imprime les éléments d'une liste 
; ARGS :  liste
; USAGES : (imprimer-liste liste) > (imprimer-liste '("bonjour" "je")) > bonjour je
; GLOBALS : none
; CALL : none
; USER : answer

(defun imprimer-liste (liste)
  (cond 
      ((not liste) nil)  ; si la liste est finie, on renvoie nil 
      (t (princ (car liste))  ; sinon on princ le 1er élmt de la lst
        (princ " ") ; on ajoute un espace
        (imprimer-liste (cdr liste)) ; on récurse 
        t ) ) ) ; renvoie t pour ne pas avoir un nil qui met fin au programme 


; NAME : print-output > la gestion des impressions en sortie 
; ARGS :  output-pattern
; USAGES : (imprimer-liste liste) > (imprimer-liste '("bonjour" "je")) > bonjour je
; GLOBALS : none
; CALL : none
; USER : answer

(defun print-output (output-pattern)
  (cond
      ((atom output-pattern) (not output-pattern))
      (t
        (print-with-joker (car output-pattern)) 
        (print-output (cdr output-pattern)) ) ) ) ; retrait () autour de cdr 
        


; NAME : print-with-joker > gestion de l'impression des jokers 
; ARGS :  output-word &optional result
; GLOBALS : Variables, Resultats 
; CALL : butfirst 
; USER : print-output 

(defun print-with-joker (output-word &optional result)
  (setq result ; maj de result selon le retour de cond 
    (cond ; cond plutôt que if
      
        ; si sortie est une liste non nulle qui commence par >
        ((and (consp output-word) (eq (car output-word) '>))
          (+z (get 'Variables (cadr output-word))) ) ; on appelle +z

        ; si la sortie est $ 
        ((and (eq output-word '$) (= (length (string output-word)) 1))
          (get 'Variables 'joker) ) ; on récupère joker 
        
        ; si la sortie est >var
        ((eq (char (string output-word) 0) '#\>)
          (get 'Variables (butfirst output-word)) )

        (t output-word) ) ) ; sinon renvoie la sortie 
        (push result Resultats) ) ; on push result dans lst Resultats



; NAME : butfirst 
;       > renvoie un atome dont le nom est celui de l'arg moins premiere caractère
; ARGS :  mot
; GLOBALS : none 
; CALL : none 
; USER : print-with-joker 

(defun butfirst (mot)
  (intern (subseq (string mot) 1)) )  
  ; isole la fin du mot à partir de 1 puis intern


; NAME : +z
;       > renvoie un mot avec un z à la fin 
; ARGS :  mot
; GLOBALS : none 
; CALL : none 
; USER : print-with-joker 

(defun +z (mot)
  (concatenate 'string (string mot) "z") )
  ; ajoute z à la fin du mot, forme une str


; NAME : appartient 
;       > renvoie le mot s'il appartient à une liste donnée ou nil
; ARGS :  mot &rest lesoptions
; GLOBALS : none 
; CALL : none 
; USER : match

(defun appartient (mot &rest lesoptions)
  (car (member mot lesoptions)) )
  ; vérifie si le mot appartient à la lst des lesoptions


; NAME : nompropre
;       > renvoie nil ou t selon que le mot commence par une maj
; ARGS :  mot
; GLOBALS : none 
; CALL : none 
; USER : match

(defun nompropre (mot)
  (upper-case-p (char (string mot) 0)) ) 
  ; vérifie si le mot commence par une majuscule 

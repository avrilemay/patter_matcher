; Nom ......... : PM_11_data.lisp
; Rôle ........ : données pour le pattern matcher 
; Auteur ...... : Avrile Floro 
; Version ..... : V0.1 du 14/12/23
; Licence ..... : réalisé dans le cadre du cours d'Algo 1
; Usage : lisp puis (load "PM_11.lisp") puis (Eliza patterns)


; NAME : patterns 
; USAGES : initialisation des patrons et réponses  
; USER : Eliza 

(setq patterns '(((* ça va *) Je vais très bien. Merci. Et vous?)
  ((* (appartient A Bonjour bonjour Bonsoir bonsoir salut Salut Hey hey hello Hello) *) Bonjour!)
  ((Comment allez-vous *) Très bien. Merci. Et vous?)
  ((* vais * bien *) Super.)
  ((Très bien *) Parfait.)
  (( * poser * questions *) Bien sûr je vous écoute.)
  ((* (appartient A écologie écologie écologique réchauffement climatique climat) *) Ma France pour transformer le climat comprend un Pacte européen notamment pour le climat représentant neuf cents milliards. )
  ((* (appartient A énergie énergies énergétique nucléaire renouvelable) *) Je souhaite que la France utilise un mix énergétique nucléaire et renouvelable pour assurer notre souveraineté.)
  (( * (appartient A guerre combat combats massacre massacres) *) La France doit faire entendre la voix de la paix de la solidarité.)   
  (( * (appartient A discriminations discrimination racisme raciste racistes) * (appartient A juif juifs juives musulmans musulmans musulmanes Islam) * ) Ma priorité est la paix en France. Aucun citoyen ne sera oublié. En outre je souhaite renforcer la laïcité en France et garantir le strict respect de la loi de mille neuf cent cinq. ) 
  (( * (appartient A âge départ) * retraite *) La retraite passera à soixante ans si je suis élu!)
  (( * pensions * retraite * ) Les retraites ne seront pas inférieures à mille deux cents euros net.)
  (( * (appartient A salaire salaires) * ) Nous devons changer cela. Mon objectif est de proposer de bons salaires. Le smic doit être établi à mille neuf cent vingt-trois euros brut soit mille cinq cents euros net.)
  (( * (appartient A triste énervé écoeuré mécontent) *) Moi aussi je suis très >A à cause des échecs du Président de la République actuel.)
  (( * (appartient A je Je) * vous * (appartient B apprécie écoute admire aime) ($ C) *) Vous (> B +z) >C un partisan de la République française partout et pour toutes et tous. Merci ça me touche. Je et du plus profond de mon coeur >B tous les Français également!)
  (( * (appartient A veux désire besoin) * plus de *) Ensemble nous pouvons changer les choses et porter tous les Français vers une société plus égalitaire.)
  (( * trop * (appartient A taxes réformes contraintes impôts) *) On va changer ça. Les >A inutiles seront terminés dès que je serai élu.)
  ((* répondez * ($ A nompropre) ($ B nompropre) *) Que voulez-vous que je vous dise au sujet de >A >B ?! Je préfère ne pas lui accorder de mon temps.)
  (( * (appartient A gouvernement Gouvernement) * (appartient A fait dit propose explique justifie prétend assure affirme) *) Encore un exemple de plus de la grande idiotie de ce gouvernement si vous voulez mon avis.)
  (( * (appartient A Marine Bardella) * ) Le Rassemblement National représente tout ce que je combats au quotidien. Je me bats pour une France de la paix.)
  (( * en colère *) Bien entendu que le peuple est en colère et cela ne me paraît pas surprenant en raison de la situation actuelle de la société. )
  ((* (appartient A vous Vous pensez-vous Pensez-vous) * ) Absolument cela est ma conviction.)
  ((* (appartient A merci Merci) * ) Merci à vous ce fût un plaisir.)
  ((* reparlera ($) * ) Oui on se reparlera $ ! )
  ((* Au revoir * ) À bientôt. . fin)
  ((* au revoir * ) À bientôt. . fin)
  ((* À bientôt *) Au revoir. . fin)
  ((* à bientôt *) Au revoir. . fin)
  (( * ) Je ne comprends pas bien. Reformulez je vous prie.) 
  ) ) 


; NAME : Variables 
; USAGES : initialisation des variables  
; USER : Eliza, match, $, print-with-joker 

(setq Variables '())


; NAME : résultats 
; USAGES : initialisation des résultats  
; USER : Eliza, answer, print-with-joker 

(setq Resultats '())


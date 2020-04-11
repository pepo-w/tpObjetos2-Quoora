"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestObjetosCuooraUI,
	#superclass : #PackageManifest,
	#category : #'Objetos_2-Cuoora-UI-Manifest'
}

{ #category : #'code-critics' }
ManifestObjetosCuooraUI class >> ruleRBAssignmentInIfTrueRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CuooraQuestionComponent #showProfileFrom: #false)) #'2020-04-10T22:56:48.542113-03:00') #(#(#RGMethodDefinition #(#CuooraResponsesComponent #showProfileFrom: #false)) #'2020-04-10T22:57:16.550113-03:00') )
]

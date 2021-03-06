////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialImmunization
Id:          vaccine-credential-immunization
Parent:      Immunization
Title:       "Immunization Profile - Allowable Data"
Description: "Defines a profile representing a vaccination for a vaccine credential Health Card."

* patient only Reference(VaccineCredentialPatient)
* vaccineCode MS

* occurrence[x] MS
* occurrenceDateTime 1..1 MS
* occurrenceDateTime obeys date-invariant

// Parent profile short description is not as clear as it could be
* primarySource ^short = "Information in this record from person who administered vaccine?"

* vaccineCode from VaccineCredentialVaccineValueSet (extensible)
* vaccineCode obeys vaccine-code-invariant
* vaccineCode ^definition = "Implementers SHALL use a code from VaccineCredentialVaccineValueSet if this value set contains an appropriate code."


* lotNumber MS

* protocolApplied 0..0 // See explanation in pagecontent/StructureDefinition-vaccine-credential-immunization-intro.md

* performer.actor only Reference(Organization)
* performer MS
* performer 0..1
* performer.actor ^short = "Organization which was responsible for vaccine administration."
* performer.actor ^definition = "Organization which was responsible for vaccine administration. Issuers SHOULD provide display name only. This is provided to Verifiers in case of invalid data in the credential, to support manual validation. This is not expected to be a computable Organization identifier."

* status ^short = "Whether or not the vaccination was completed"

* reportOrigin from VaccineCredentialReportOriginValueSet (extensible)
* site from VaccineCredentialVaccineSiteValueSet (extensible)
* route from VaccineCredentialVaccineRouteValueSet (extensible)
* fundingSource from VaccineCredentialFundingSourceValueSet (extensible)
* statusReason from VaccineCredentialStatusReasonValueSet (extensible)

* reaction.detail only Reference(VaccineCredentialVaccineReactionObservation)

* isSubpotent MS
* isSubpotent ^definition = "Indication if a dose is considered to be subpotent. By default, a dose should be considered to be potent. Verifiers SHALL assume that if an Immunization resource is provided and isSubpotent is not true, then the dose was not subpotent. Issuers SHALL only populate isSubpotent if the value is true. Issuers SHALL NOT produce an Immunization resource for a known subpotent dose without populating isSubpotent."

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:     VaccineCredentialImmunizationDM
Id:          vaccine-credential-immunization-dm
Parent:      VaccineCredentialImmunization
Title:       "Immunization Profile - Data Minimization"
Description: "Defines a profile representing a vaccination for a vaccine credential Health Card. Only elements necessary for Verifiers can be populated."

* meta 0..0
* implicitRules 0..0
* language 0..0
* text 0..0
* contained 0..0
* extension 0..0
* modifierExtension 0..0
* statusReason 0..0
* encounter 0..0
* recorded 0..0
* primarySource 0..0
* reportOrigin 0..0
* location 0..0
* manufacturer 0..0
* expirationDate 0..0
* site 0..0
* route 0..0
* doseQuantity 0..0
* performer.function 0..0
* note 0..0
* reasonCode 0..0
* reasonReference 0..0
* subpotentReason 0..0
* education 0..0
* fundingSource 0..0
* reaction 0..0

// Required in DM profile to provide implementers with sterner warning when straying from the expected value sets
* vaccineCode from VaccineCredentialVaccineValueSet (required)


////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialVaccineReactionObservation
Parent:         Observation
Id:             vaccine-credential-vaccine-reaction-observation
Title:          "Vaccine Reaction Observation Profile - Allowable Data"
Description:    "Profile for reporting a reaction to a vaccine.

This profile may not be necessary depending on the use cases for this IG, but it's included for now because
we wanted to have value sets corresponding to all the value sets in the IIS core data elements. In this
profile, VaccineCredentialVaccineReactionValueSet includes the IIS adverse reaction codes."
* ^status = #draft

* code = SCT#293104008 "Vaccines adverse reaction (disorder)"

* subject only Reference(VaccineCredentialPatient)
* subject 1..1 MS
* subject ^short = "Patient with reaction to vaccine"
* subject ^definition = "Reference to a VaccineCredentialPatient-conforming resource who had a reaction to the vaccine."

// Not sure if this is the best element to use to refer to the immunization(s) attributed to the reaction
* focus only Reference(VaccineCredentialImmunization)
* focus 1..* MS
* focus ^short = "Immunization causing the reaction"
* focus ^definition = "Reference to the VaccineCredentialImmunization-conforming resource representing the vaccination(s) causing the reaction."

* value[x] only CodeableConcept
* valueCodeableConcept 1..1 MS
* valueCodeableConcept from VaccineCredentialVaccineReactionValueSet (extensible)

////////////////////////////////////////////////////////////////////////////////////////////////////

Profile:        VaccineCredentialVaccineReactionObservationDM
Parent:         VaccineCredentialVaccineReactionObservation
Id:             vaccine-credential-vaccine-reaction-observation-dm
Title:          "Vaccine Reaction Observation Profile - Data Minimization"
Description:    "Profile for reporting a reaction to a vaccine. Only elements necessary for Verifiers can be populated."

* meta 0..0
* implicitRules 0..0
* language 0..0
* text 0..0
* contained 0..0
* extension 0..0
* modifierExtension 0..0
* basedOn 0..0
* partOf 0..0
* category.id 0..0
* category.extension 0..0
* category.text 0..0
* issued 0..0
* performer 0..0
* dataAbsentReason 0..0
* interpretation 0..0
* note 0..0
* bodySite 0..0
* method 0..0
* specimen 0..0
* device 0..0
* referenceRange 0..0
* hasMember 0..0
* derivedFrom 0..0
* component 0..0
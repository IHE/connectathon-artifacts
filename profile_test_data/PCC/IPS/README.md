Connectathon IPS Testing will use coded data for several patients. It is our goal to use existing public value sets whenever possible and to select the code values from these. There will be some test cases where specific values from a value set are chosen. Other test cases will allow you the freedom to select values. We do not intend to ask a client application to create resources that will demonstrate the use of each value in a value set. That would be a good test for conformance but is not a Connectathon goal for IPS testing.

The IPS composition (http://hl7.org/fhir/uv/ips/ipsStructure.html) has three required sections. These are:
* Medication Summary
* Allergies and Intolerances
* Problem List
We will test these using the patients and data described bellow.

## Patient List
You will need four patients to run these test cases. You can select these from the list of patients that are documented here: (TBD).  If you have been assigned a patient in your role as an XDS Document Creator, that patient can serve as one of the patients in the set. To complete the set of four patients, select from the patients that are defined for your country. This will give you the opportunity to support names and possibly other demographics that are appropriate for your market. If you decide it is easier to select four patients from that list from another country, please let us know. That might mean we are giving you conflicting instructions, and we are trying to simplify the process.

These four patients will be referred to as P1, P2, P3 and P4

## Value Sets
We have defined value sets for some of the coded values to be used during Connectathon testing. There are overlapping goals:

 - Use coded values that are realistic
 - Make use of existing value sets so that we do not have to invent code values
 - Make use of existing value set files/documentation to be aligned with other efforts.
 - Publish value sets in central locations to simplify discovery

Code value requirements for test cases are described in the **Sections** area below. The following table is a list of the value sets that are referenced for IPS testing.
| Concept | Value Set ID |HL7 Documentation| FHIR Server URL | File in GitHub Repository |
|--|--|--|--|--|
|Medication Summary|medication-example-uv-ips|http://hl7.org/fhir/uv/ips/ValueSet-medication-example-uv-ips.html|http://cat-nist-tools.ihe-europe.net:6080/hapi-fhir-rw/baseR4/ValueSet/medication-example-uv-ips/_history/1| TBD |
|Allergies and Intolerances | allergy-intolerance-substance-condition-gps-uv-ips | http://hl7.org/fhir/uv/ips/ValueSet-allergy-intolerance-substance-condition-gps-uv-ips.html| TBD | TBD |
|Condition | condition-code |http://hl7.org/fhir/R4/valueset-condition-code.html| TBD | TBD |



## Sections

### Medication Summary
The Medication Summary section is expressed using the [Medication Statement](http://hl7.org/fhir/uv/ips/StructureDefinition-MedicationStatement-uv-ips.html) resource or the [Medication](http://hl7.org/fhir/uv/ips/StructureDefinition-Medication-uv-ips.html) resource as constrained by the IPS IG. You may choose to test with either resource. Use patients P1 and P2 with the Medication Statement and patients P3 and P4 with the Medication resource. See the table below for details.
|Patient| Resource |Medication List|
|--|--|--|
| P1 | Medication Statement | Use these specific coded medications: 777067000, 774587000, 776556004 |
| P2 | Medication Statement | Choose any two from the value set, excluding the three specified for P1 |
| P3 | Medication | Use these specific coded medications: 777067000, 774587000, 776556004 |
| P4 | Medication | Choose any two from the value set, excluding the three specified for P3 |


### Allergies and Intolerances
Allergies and Intolerances are expressed using the [AllergyIntolerance](http://hl7.org/fhir/uv/ips/StructureDefinition-AllergyIntolerance-uv-ips.html) resource as constrained by the IPS IG.

Use patients P1, P2 and P3 with the coded values for Allergies and Intolerances as listed in the table below.
|Patient|Allergies and Intolerances|
|--|--|
|P1|58281002|
|P2|412071004, 762952008, 264295007|
|P3|Choose any three from the value set, excluding those specified for P1 and P2|


### Problem List
The Problem List section contains items expressed using the [Condition](http://hl7.org/fhir/uv/ips/StructureDefinition-Condition-uv-ips.html) resource  as constrained by the IPS IG.

Use patients P1, P2 and P3 with the coded values for Condition as listed in the table below.
|Patient|Condition|
|--|--|
|P1|165002|
|P2|330007, 368009, 615005, 3544004|
|P3|Choose any three from the value set, excluding those specified for P1 and P2|


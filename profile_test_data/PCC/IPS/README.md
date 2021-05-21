This folder contains HL7 IPS example files from different sources. Files are not guaranteed to be correct. Please use them to extract the clinical data needed for your testing. Explanations / expectations are documented for IHE Connectathon testing of the IPS, QEDm and mXDE profiles can be found:
- [IPS](https://gazelle.ihe.net/content/ips-connectathon-read-first)
- [QEDm](https://gazelle.ihe.net/content/qedm-connectathon-read-first)
- [mXDE](https://gazelle.ihe.net/content/mxdeqedmreadthisfirst)

The table below describes subfolders and origin of the files in the folders. Notes:
- The ips-dstu3 and ips-r4 folders contain content from different versions of the HL7 FHIR IPS IG. The metadata and clinical content are intended to be the same. Differences might occur because of how the files were generated.
- The ips-cda folder contains CDA documents that are intended to satisfy the IHE IPS CDA requirements. These files are hand coded and likely contain errors.
- The c-cda folder contains C-CDA documents that originated as samples in the US.
    - IPS Testing: The CCD documents are of no use to you.
    - QEDm / Provenance Testing: The CCD documents are used for creating Provenance records.


| Subfolder | File Type | Data Origin |
| --- | ---  | --- |
| c-cda |  Consolidate CDA | Hand constructed but relies on https://github.com/HL7/C-CDA-Examples |
| ips-cda | IPS CDA | Hand constructed but relies on Trillium Bridge samples |
| ips-dstu3 | IPS (DSTU3) | From the Trillium Bridge project |
| ips-r4 | IPS (R4) | From the Trillium Bridge project |

The table below lists folders and files for test patients.
- A row with multiple entries means that the content of the files is intended to be the same even if the encoding is slightly different.
- Naming conventions
    - Some file names contain a string with the pattern "eumf-xx-yy". The string is the one created by the Trillium Bridge project to identify the patient. We maintained that naming convention with the hand constructed files.
    - Other files contain a string with the pattern "ihered-xxxx". These files are for patients not originally in the Trillium Bridge project. The string refers to a patient identifier in the IHE Red Affinity Domain used for IHE testing.
- File extensions are omitted as the file might exist in json format in one folder and XML in another.
- We hinted above but will be more explicit here.
    - The files you use for IHE testing will depend on the profile you are testing.
    - As a system that is expected to create content based on these files, you might need to import / process all of the data listed below.
    - Please read the pages linked at the top for instructions for testing in each IHE profile. We are not repeating those instructions here. This is an index.

| Patient | File | c-cda | ips-cda | ips-dstu3 | ips-r4 |
| ---| ---| :---:| :---: | :---:| :---: |
| Charles Merlot | bundle-eumfh-43-155-ips    |   |   | X |   |
| Mary Gines     | bundle-eumfh-70-300-1-ips  |   | X | X |   |
| Chadwick Ross  | ihered-3162-ccd-1          | X |   |   |   |
| Chadwick Ross  | ihered-3162-procedure-1    | X |   |   |   |
| Chadwick Ross  | ihered-3162-diag_imaging-1 | X |   |   |   |
| Annelise Black | bundle-eumfh-70-275-ips    |   |   |   |   |
| Marco Peroni   | bundle-eumfh-70-288-ips    |   | X | X | X |
| Allen Perot    | bundle-eumfh-70-295-ips    |   |   | X |   |


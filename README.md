# connectathon-artifacts
The files and folders in this repository are the source material for artifacts including value sets used in IHE Connectathons. In general, tab delimited files are maintained as the source of truth.  A master configuration file and a set of perl scripts convert the tab delimited files into output formats used during the a Connectathon. Reasons for choosing this scheme are found at the bottom of this file.

## Generating Output
From this top level folder, execute:

`perl scripts/master.pl [path]`

where path is an optional argument that points to a root folder for output.  The script will use a default value of "." if no path is specified.

The script reads each line of master.txt and produces output based on each line. A description of the contents and format of entries are included at the top of master.txt

## Discussion of Tab Delimited Files and Perl Scripts
Connectathon value sets have been distributed in various formats starting with the first IHE Connectathon in 1999.  The first versions were not machine readable. Bill Majurski of NIST designed a codes.xml file that includes coded values used by his XDS Toolkit. He intended it for internal use, but XDS developers adopted that format to configure their software, at least in the context of Connectathon testing. HL7 FHIR(R) now has a standardized way to create a machine readable file with a list of codes to form a value set. The specification supports JSON and XML encodings.

We chose a model where the source data (codes) are stored in tab delimited spreadsheets with associated perl scripts to convert these into various formats used during a Connectathon. The main driver is our experience in managing the codes themselves. It is much easier to visualize and maintain the codes in the grid structure of a spreadsheet than it is to manage in JSON or XML. The maintainers of the coded values (Lynn Felhofer, Steve Moore) want to see the patterns that are expressed in the columns and use that as a secondary means to ensure consistency.

Perl was chosen to transform the tab delimited files into other formats because it is an interpreted language and available on all platforms. The perl scripts do not require any external modules and should execute with a baseline version of perl. We acknowledge that some operations would be more elegant with other languages and/or XSL transformations.

One overriding decision is that we wanted one source of truth and did not want to maintain multiple copies of the codes. We could have chosen to maintain equivalent files in XML, JSON and other formats so that this repository contained final output and was ready for use without any transformation. We rejected that approach because we did not want to spend time checking for consistency between the files.

Feature: US13002_DT13919
	As a Rave user
	When I navigate to a log form that has a Dynamic Search List
	And I click the Dynamic Search List dropdown button to display matching results
	Then the Dynamic Search List dropdown is open within 3 seconds
# A field on a log form that has a Dynamic Search List should display matching results within 3 seconds.
# When data is entered into a field on a log form that has a Dynamic Search List, and the drop-down list that displays matching results is clicked, it takes a long time to display matching results.

Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#And the following Project assignments exist
	#	 | User    | Project | Environment | Role | Site       | Site Number |
	#	 | defuser | L1WP-GT | Prod        | cdm1 | Site 1     | S100        |
	#	 | defuser | L1WP-GT | Prod        | cdm1 | Site 13919 | 13919       |
	# And Site "Site 13919" is set to "Allow DDE"
	# And Repeating Default Delimiter is ","
	# And Role "cdm1" has Action "Entry"
	# And Project "L1WP-GT" has Draft "<Draft1>"
	# And Draft "<Draft1>" has Form "Adverse Event Form" with fields
		# | VarOID    | Field OID | Data Format | Data Dictionary | Control Type       | Field Label                                                               | IsLog | Default Value                                                                    |
		# | CYCLE     | CYCLE     | 3           |                 | Text               | Visit                                                                     | False |                                                                                  |
		# | EVAL_DT   | EVAL_DT   | dd MMM yyyy |                 | DateTime           | Reporting Period End Date                                                 | False |                                                                                  |
		# |           | NOTE      |             |                 | Text               | <b>Solicited Adverse Events </b>                                          | False |                                                                                  |
		# | TOXXX     | TOXXX     | 10          | CTCAE_403_TERM  | DropDownList       | Adverse Event Text Name (CTCAE v4.0)                                      | True  | 10021143,10003658,10003598,10061229,10035742,10011224,10037383,10008496,10017076 |
		# | MEDRAXX   | MEDRAXX   | 10          |                 | Text               | MedDRA Adverse Event Code (v12.0)                                         | True  | 10021143,10003658,10003598,10061229,10035742,10011224,10037383,10008496,10017076 |
		# | TOXNEXX   | TOXNEXX   | 1           |                 | CheckBox           | Adverse Event Not Evaluated                                               | True  |                                                                                  |
		# | VALSOL    | VALXX     | 2           |                 | Dynamic SearchList | Adverse Event Grade                                                       | True  |                                                                                  |
		# | VALDESCXX | VALDESCXX | $700        |                 | LongText           | Adverse Event Grade Description                                           | True  |                                                                                  |
		# | TOX_RLXX  | TOX_RLXX  | 1           | TOX_RL          | DropDownList       | CTC Adverse Event Attribution Scale                                       | True  |                                                                                  |
		# | AER_XX    | AER_XX    | 1           | YESNO           | RadioButton        | Has an adverse event expedited report been submitted?                     | True  |                                                                                  |
		# | OTHAE     | OTHAE     | 1           | OTHAE           | DropDownList       | Were <i>(other)</i> adverse events assessed during this reporting period? | False |                                                                                  |
		# | COMTOXS   | COMTOXS   | $200        |                 | LongText           | Comments                                                                  | False |                                                                                  |
	# And Data Dictionary "CTCAE_403_TERM" has entries
		# | User Value                                                                         | Coded Value | Specify |
		# | Anemia                                                                             | 10002272    | FALSE   |
		# | Bone marrow hypocellular                                                           | 10048580    | FALSE   |
		# | Disseminated intravascular coagulation                                             | 10013442    | FALSE   |
		# | Febrile neutropenia                                                                | 10016288    | FALSE   |
		# | Hemolysis                                                                          | 10019491    | FALSE   |
		# | Hemolytic uremic syndrome                                                          | 10019515    | FALSE   |
		# | Leukocytosis                                                                       | 10024378    | FALSE   |
		# | Lymph node pain                                                                    | 10025182    | FALSE   |
		# | Spleen disorder                                                                    | 10041633    | FALSE   |
		# | Thrombotic thrombocytopenic purpura                                                | 10043648    | FALSE   |
		# | Blood and lymphatic system disorders - Other specify                               | 10005329    | TRUE    |
		# | Acute coronary syndrome                                                            | 10051592    | FALSE   |
		# | Aortic valve disease                                                               | 10061589    | FALSE   |
		# | Asystole                                                                           | 10003586    | FALSE   |
		# | Atrial fibrillation                                                                | 10003658    | FALSE   |
		# | Atrial flutter                                                                     | 10003662    | FALSE   |
		# | Atrioventricular block complete                                                    | 10003673    | FALSE   |
		# | Atrioventricular block first degree                                                | 10003674    | FALSE   |
		# | Cardiac arrest                                                                     | 10007515    | FALSE   |
		# | Chest pain - cardiac                                                               | 10008481    | FALSE   |
		# | Conduction disorder                                                                | 10010276    | FALSE   |
		# | Constrictive pericarditis                                                          | 10010783    | FALSE   |
		# | Heart failure                                                                      | 10019279    | FALSE   |
		# | Left ventricular systolic dysfunction                                              | 10069501    | FALSE   |
		# | Mitral valve disease                                                               | 10061532    | FALSE   |
		# | Mobitz (type) II atrioventricular block                                            | 10027786    | FALSE   |
		# | Mobitz type I                                                                      | 10027787    | FALSE   |
		# | Myocardial infarction                                                              | 10028596    | FALSE   |
		# | Myocarditis                                                                        | 10028606    | FALSE   |
		# | Palpitations                                                                       | 10033557    | FALSE   |
		# | Paroxysmal atrial tachycardia                                                      | 10034040    | FALSE   |
		# | Pericardial effusion                                                               | 10034474    | FALSE   |
		# | Pericardial tamponade                                                              | 10053565    | FALSE   |
		# | Pericarditis                                                                       | 10034484    | FALSE   |
		# | Pulmonary valve disease                                                            | 10061541    | FALSE   |
		# | Restrictive cardiomyopathy                                                         | 10038748    | FALSE   |
		# | Right ventricular dysfunction                                                      | 10058597    | FALSE   |
		# | Sick sinus syndrome                                                                | 10040639    | FALSE   |
		# | Sinus bradycardia                                                                  | 10040741    | FALSE   |
		# | Sinus tachycardia                                                                  | 10040752    | FALSE   |
		# | Supraventricular tachycardia                                                       | 10042604    | FALSE   |
		# | Tricuspid valve disease                                                            | 10061389    | FALSE   |
		# | Ventricular arrhythmia                                                             | 10047281    | FALSE   |
		# | Ventricular fibrillation                                                           | 10047290    | FALSE   |
		# | Ventricular tachycardia                                                            | 10047302    | FALSE   |
		# | Wolff-Parkinson-White syndrome                                                     | 10048015    | FALSE   |
		# | Cardiac disorders - Other specify                                                  | 10007541    | TRUE    |
		# | Congenital familial and genetic disorders - Other specify                          | 10010331    | TRUE    |
		# | Ear pain                                                                           | 10014020    | FALSE   |
		# | External ear inflammation                                                          | 10065837    | FALSE   |
		# | External ear pain                                                                  | 10065785    | FALSE   |
		# | Hearing impaired                                                                   | 10019245    | FALSE   |
		# | Middle ear inflammation                                                            | 10065838    | FALSE   |
		# | Tinnitus                                                                           | 10043882    | FALSE   |
		# | Vertigo                                                                            | 10047340    | FALSE   |
		# | Vestibular disorder                                                                | 10047386    | FALSE   |
		# | Ear and labyrinth disorders - Other specify                                        | 10013993    | TRUE    |
		# | Adrenal insufficiency                                                              | 10001367    | FALSE   |
		# | Cushingoid                                                                         | 10011655    | FALSE   |
		# | Delayed puberty                                                                    | 10012205    | FALSE   |
		# | Growth accelerated                                                                 | 10018746    | FALSE   |
		# | Hyperparathyroidism                                                                | 10020705    | FALSE   |
		# | Hyperthyroidism                                                                    | 10020850    | FALSE   |
		# | Hypoparathyroidism                                                                 | 10021041    | FALSE   |
		# | Hypothyroidism                                                                     | 10021114    | FALSE   |
		# | Precocious puberty                                                                 | 10058084    | FALSE   |
		# | Virilization                                                                       | 10047488    | FALSE   |
		# | Endocrine disorders - Other specify                                                | 10014698    | TRUE    |
		# | Blurred vision                                                                     | 10005886    | FALSE   |
		# | Cataract                                                                           | 10007739    | FALSE   |
		# | Conjunctivitis                                                                     | 10010741    | FALSE   |
		# | Corneal ulcer                                                                      | 10048492    | FALSE   |
		# | Dry eye                                                                            | 10013774    | FALSE   |
		# | Extraocular muscle paresis                                                         | 10015829    | FALSE   |
		# | Eye pain                                                                           | 10015958    | FALSE   |
		# | Eyelid function disorder                                                           | 10061145    | FALSE   |
		# | Flashing lights                                                                    | 10016757    | FALSE   |
		# | Floaters                                                                           | 10016778    | FALSE   |
		# | Glaucoma                                                                           | 10018304    | FALSE   |
		# | Keratitis                                                                          | 10023332    | FALSE   |
		# | Night blindness                                                                    | 10029404    | FALSE   |
		# | Optic nerve disorder                                                               | 10061322    | FALSE   |
		# | Papilledema                                                                        | 10033703    | FALSE   |
		# | Photophobia                                                                        | 10034960    | FALSE   |
		# | Retinal detachment                                                                 | 10038848    | FALSE   |
		# | Retinal tear                                                                       | 10038897    | FALSE   |
		# | Retinal vascular disorder                                                          | 10038901    | FALSE   |
		# | Retinopathy                                                                        | 10038923    | FALSE   |
		# | Scleral disorder                                                                   | 10061510    | FALSE   |
		# | Uveitis                                                                            | 10046851    | FALSE   |
		# | Vitreous hemorrhage                                                                | 10047656    | FALSE   |
		# | Watering eyes                                                                      | 10047848    | FALSE   |
		# | Eye disorders - Other specify                                                      | 10015919    | TRUE    |
		# | Abdominal distension                                                               | 10000060    | FALSE   |
		# | Abdominal pain                                                                     | 10000081    | FALSE   |
		# | Anal fistula                                                                       | 10002156    | FALSE   |
		# | Anal hemorrhage                                                                    | 10055226    | FALSE   |
		# | Anal mucositis                                                                     | 10065721    | FALSE   |
		# | Anal necrosis                                                                      | 10065722    | FALSE   |
		# | Anal pain                                                                          | 10002167    | FALSE   |
		# | Anal stenosis                                                                      | 10002176    | FALSE   |
		# | Anal ulcer                                                                         | 10002180    | FALSE   |
		# | Ascites                                                                            | 10003445    | FALSE   |
		# | Bloating                                                                           | 10005265    | FALSE   |
		# | Cecal hemorrhage                                                                   | 10065747    | FALSE   |
		# | Cheilitis                                                                          | 10008417    | FALSE   |
		# | Colitis                                                                            | 10009887    | FALSE   |
		# | Colonic fistula                                                                    | 10009995    | FALSE   |
		# | Colonic hemorrhage                                                                 | 10009998    | FALSE   |
		# | Colonic obstruction                                                                | 10010000    | FALSE   |
		# | Colonic perforation                                                                | 10010001    | FALSE   |
		# | Colonic stenosis                                                                   | 10010004    | FALSE   |
		# | Colonic ulcer                                                                      | 10010006    | FALSE   |
		# | Constipation                                                                       | 10010774    | FALSE   |
		# | Dental caries                                                                      | 10012318    | FALSE   |
		# | Diarrhea                                                                           | 10012727    | FALSE   |
		# | Dry mouth                                                                          | 10013781    | FALSE   |
		# | Duodenal fistula                                                                   | 10013828    | FALSE   |
		# | Duodenal hemorrhage                                                                | 10055242    | FALSE   |
		# | Duodenal obstruction                                                               | 10013830    | FALSE   |
		# | Duodenal perforation                                                               | 10013832    | FALSE   |
		# | Duodenal stenosis                                                                  | 10050094    | FALSE   |
		# | Duodenal ulcer                                                                     | 10013836    | FALSE   |
		# | Dyspepsia                                                                          | 10013946    | FALSE   |
		# | Dysphagia                                                                          | 10013950    | FALSE   |
		# | Enterocolitis                                                                      | 10014893    | FALSE   |
		# | Enterovesical fistula                                                              | 10062570    | FALSE   |
		# | Esophageal fistula                                                                 | 10065851    | FALSE   |
		# | Esophageal hemorrhage                                                              | 10015384    | FALSE   |
		# | Esophageal necrosis                                                                | 10065727    | FALSE   |
		# | Esophageal obstruction                                                             | 10015387    | FALSE   |
		# | Esophageal pain                                                                    | 10015388    | FALSE   |
		# | Esophageal perforation                                                             | 10055472    | FALSE   |
		# | Esophageal stenosis                                                                | 10015448    | FALSE   |
		# | Esophageal ulcer                                                                   | 10015451    | FALSE   |
		# | Esophageal varices hemorrhage                                                      | 10015453    | FALSE   |
		# | Esophagitis                                                                        | 10015461    | FALSE   |
		# | Fecal incontinence                                                                 | 10016296    | FALSE   |
		# | Flatulence                                                                         | 10016766    | FALSE   |
		# | Gastric fistula                                                                    | 10065713    | FALSE   |
		# | Gastric hemorrhage                                                                 | 10017789    | FALSE   |
		# | Gastric necrosis                                                                   | 10051886    | FALSE   |
		# | Gastric perforation                                                                | 10017815    | FALSE   |
		# | Gastric stenosis                                                                   | 10061970    | FALSE   |
		# | Gastric ulcer                                                                      | 10017822    | FALSE   |
		# | Gastritis                                                                          | 10017853    | FALSE   |
		# | Gastroesophageal reflux disease                                                    | 10066874    | FALSE   |
		# | Gastrointestinal fistula                                                           | 10017877    | FALSE   |
		# | Gastrointestinal pain                                                              | 10017999    | FALSE   |
		# | Gastroparesis                                                                      | 10018043    | FALSE   |
		# | Gingival pain                                                                      | 10018286    | FALSE   |
		# | Hemorrhoidal hemorrhage                                                            | 10060640    | FALSE   |
		# | Hemorrhoids                                                                        | 10019611    | FALSE   |
		# | Ileal fistula                                                                      | 10065728    | FALSE   |
		# | Ileal hemorrhage                                                                   | 10055287    | FALSE   |
		# | Ileal obstruction                                                                  | 10065730    | FALSE   |
		# | Ileal perforation                                                                  | 10021305    | FALSE   |
		# | Ileal stenosis                                                                     | 10021307    | FALSE   |
		# | Ileal ulcer                                                                        | 10021309    | FALSE   |
		# | Ileus                                                                              | 10021328    | FALSE   |
		# | Intra-abdominal hemorrhage                                                         | 10055291    | FALSE   |
		# | Jejunal fistula                                                                    | 10065719    | FALSE   |
		# | Jejunal hemorrhage                                                                 | 10055300    | FALSE   |
		# | Jejunal obstruction                                                                | 10065732    | FALSE   |
		# | Jejunal perforation                                                                | 10023174    | FALSE   |
		# | Jejunal stenosis                                                                   | 10023176    | FALSE   |
		# | Jejunal ulcer                                                                      | 10023177    | FALSE   |
		# | Lip pain                                                                           | 10024561    | FALSE   |
		# | Lower gastrointestinal hemorrhage                                                  | 10051746    | FALSE   |
		# | Malabsorption                                                                      | 10025476    | FALSE   |
		# | Mucositis oral                                                                     | 10028130    | FALSE   |
		# | Nausea                                                                             | 10028813    | FALSE   |
		# | Obstruction gastric                                                                | 10029957    | FALSE   |
		# | Oral cavity fistula                                                                | 10065720    | FALSE   |
		# | Oral dysesthesia                                                                   | 10054520    | FALSE   |
		# | Oral hemorrhage                                                                    | 10030980    | FALSE   |
		# | Oral pain                                                                          | 10031009    | FALSE   |
		# | Pancreatic duct stenosis                                                           | 10065703    | FALSE   |
		# | Pancreatic fistula                                                                 | 10049192    | FALSE   |
		# | Pancreatic hemorrhage                                                              | 10033626    | FALSE   |
		# | Pancreatic necrosis                                                                | 10058096    | FALSE   |
		# | Pancreatitis                                                                       | 10033645    | FALSE   |
		# | Periodontal disease                                                                | 10034536    | FALSE   |
		# | Peritoneal necrosis                                                                | 10065704    | FALSE   |
		# | Proctitis                                                                          | 10036774    | FALSE   |
		# | Rectal fistula                                                                     | 10038062    | FALSE   |
		# | Rectal hemorrhage                                                                  | 10038064    | FALSE   |
		# | Rectal mucositis                                                                   | 10063190    | FALSE   |
		# | Rectal necrosis                                                                    | 10065709    | FALSE   |
		# | Rectal obstruction                                                                 | 10065707    | FALSE   |
		# | Rectal pain                                                                        | 10038072    | FALSE   |
		# | Rectal perforation                                                                 | 10038073    | FALSE   |
		# | Rectal stenosis                                                                    | 10038079    | FALSE   |
		# | Rectal ulcer                                                                       | 10038080    | FALSE   |
		# | Retroperitoneal hemorrhage                                                         | 10038981    | FALSE   |
		# | Salivary duct inflammation                                                         | 10056681    | FALSE   |
		# | Salivary gland fistula                                                             | 10039411    | FALSE   |
		# | Small intestinal mucositis                                                         | 10065710    | FALSE   |
		# | Small intestinal obstruction                                                       | 10041101    | FALSE   |
		# | Small intestinal perforation                                                       | 10041103    | FALSE   |
		# | Small intestinal stenosis                                                          | 10062263    | FALSE   |
		# | Small intestine ulcer                                                              | 10041133    | FALSE   |
		# | Stomach pain                                                                       | 10042112    | FALSE   |
		# | Tooth development disorder                                                         | 10044030    | FALSE   |
		# | Tooth discoloration                                                                | 10044031    | FALSE   |
		# | Toothache                                                                          | 10044055    | FALSE   |
		# | Typhlitis                                                                          | 10045271    | FALSE   |
		# | Upper gastrointestinal hemorrhage                                                  | 10055356    | FALSE   |
		# | Vomiting                                                                           | 10047700    | FALSE   |
		# | Gastrointestinal disorders - Other specify                                         | 10017947    | TRUE    |
		# | Chills                                                                             | 10008531    | FALSE   |
		# | Death neonatal                                                                     | 10011912    | FALSE   |
		# | Death NOS                                                                          | 10011914    | FALSE   |
		# | Edema face                                                                         | 10014222    | FALSE   |
		# | Edema limbs                                                                        | 10050068    | FALSE   |
		# | Edema trunk                                                                        | 10058720    | FALSE   |
		# | Facial pain                                                                        | 10016059    | FALSE   |
		# | Fatigue                                                                            | 10016256    | FALSE   |
		# | Fever                                                                              | 10016558    | FALSE   |
		# | Flu like symptoms                                                                  | 10016791    | FALSE   |
		# | Gait disturbance                                                                   | 10017577    | FALSE   |
		# | Hypothermia                                                                        | 10021113    | FALSE   |
		# | Infusion related reaction                                                          | 10051792    | FALSE   |
		# | Infusion site extravasation                                                        | 10064774    | FALSE   |
		# | Injection site reaction                                                            | 10022095    | FALSE   |
		# | Irritability                                                                       | 10022998    | FALSE   |
		# | Localized edema                                                                    | 10062466    | FALSE   |
		# | Malaise                                                                            | 10025482    | FALSE   |
		# | Multi-organ failure                                                                | 10028154    | FALSE   |
		# | Neck edema                                                                         | 10054482    | FALSE   |
		# | Non-cardiac chest pain                                                             | 10062501    | FALSE   |
		# | Pain                                                                               | 10033371    | FALSE   |
		# | Sudden death NOS                                                                   | 10042435    | FALSE   |
		# | General disorders and administration site conditions - Other specify               | 10018065    | TRUE    |
		# | Bile duct stenosis                                                                 | 10051341    | FALSE   |
		# | Biliary fistula                                                                    | 10004665    | FALSE   |
		# | Cholecystitis                                                                      | 10008612    | FALSE   |
		# | Gallbladder fistula                                                                | 10017631    | FALSE   |
		# | Gallbladder necrosis                                                               | 10059446    | FALSE   |
		# | Gallbladder obstruction                                                            | 10017636    | FALSE   |
		# | Gallbladder pain                                                                   | 10017638    | FALSE   |
		# | Gallbladder perforation                                                            | 10017639    | FALSE   |
		# | Hepatic failure                                                                    | 10019663    | FALSE   |
		# | Hepatic hemorrhage                                                                 | 10019678    | FALSE   |
		# | Hepatic necrosis                                                                   | 10019692    | FALSE   |
		# | Hepatic pain                                                                       | 10019705    | FALSE   |
		# | Perforation bile duct                                                              | 10034405    | FALSE   |
		# | Portal hypertension                                                                | 10036200    | FALSE   |
		# | Portal vein thrombosis                                                             | 10036206    | FALSE   |
		# | Hepatobiliary disorders - Other specify                                            | 10019805    | TRUE    |
		# | Allergic reaction                                                                  | 10001718    | FALSE   |
		# | Anaphylaxis                                                                        | 10002218    | FALSE   |
		# | Autoimmune disorder                                                                | 10061664    | FALSE   |
		# | Cytokine release syndrome                                                          | 10052015    | FALSE   |
		# | Serum sickness                                                                     | 10040400    | FALSE   |
		# | Immune system disorders - Other specify                                            | 10021428    | TRUE    |
		# | Abdominal infection                                                                | 10056519    | FALSE   |
		# | Anorectal infection                                                                | 10061640    | FALSE   |
		# | Appendicitis                                                                       | 10003011    | FALSE   |
		# | Appendicitis perforated                                                            | 10003012    | FALSE   |
		# | Arteritis infective                                                                | 10065744    | FALSE   |
		# | Biliary tract infection                                                            | 10061695    | FALSE   |
		# | Bladder infection                                                                  | 10005047    | FALSE   |
		# | Bone infection                                                                     | 10061017    | FALSE   |
		# | Breast infection                                                                   | 10006259    | FALSE   |
		# | Bronchial infection                                                                | 10055078    | FALSE   |
		# | Catheter related infection                                                         | 10007810    | FALSE   |
		# | Cecal infection                                                                    | 10065761    | FALSE   |
		# | Cervicitis infection                                                               | 10008330    | FALSE   |
		# | Conjunctivitis infective                                                           | 10010742    | FALSE   |
		# | Corneal infection                                                                  | 10061788    | FALSE   |
		# | Cranial nerve infection                                                            | 10065765    | FALSE   |
		# | Device related infection                                                           | 10064687    | FALSE   |
		# | Duodenal infection                                                                 | 10065752    | FALSE   |
		# | Encephalitis infection                                                             | 10014594    | FALSE   |
		# | Encephalomyelitis infection                                                        | 10014621    | FALSE   |
		# | Endocarditis infective                                                             | 10014678    | FALSE   |
		# | Endophthalmitis                                                                    | 10014801    | FALSE   |
		# | Enterocolitis infectious                                                           | 10058838    | FALSE   |
		# | Esophageal infection                                                               | 10058804    | FALSE   |
		# | Eye infection                                                                      | 10015929    | FALSE   |
		# | Gallbladder infection                                                              | 10062632    | FALSE   |
		# | Gum infection                                                                      | 10018784    | FALSE   |
		# | Hepatic infection                                                                  | 10056522    | FALSE   |
		# | Hepatitis viral                                                                    | 10019799    | FALSE   |
		# | Infective myositis                                                                 | 10021918    | FALSE   |
		# | Joint infection                                                                    | 10023216    | FALSE   |
		# | Kidney infection                                                                   | 10023424    | FALSE   |
		# | Laryngitis                                                                         | 10023874    | FALSE   |
		# | Lip infection                                                                      | 10065755    | FALSE   |
		# | Lung infection                                                                     | 10061229    | FALSE   |
		# | Lymph gland infection                                                              | 10050823    | FALSE   |
		# | Mediastinal infection                                                              | 10057483    | FALSE   |
		# | Meningitis                                                                         | 10027199    | FALSE   |
		# | Mucosal infection                                                                  | 10065764    | FALSE   |
		# | Nail infection                                                                     | 10061304    | FALSE   |
		# | Otitis externa                                                                     | 10033072    | FALSE   |
		# | Otitis media                                                                       | 10033078    | FALSE   |
		# | Ovarian infection                                                                  | 10055005    | FALSE   |
		# | Pancreas infection                                                                 | 10051741    | FALSE   |
		# | Papulopustular rash                                                                | 10069138    | FALSE   |
		# | Paronychia                                                                         | 10034016    | FALSE   |
		# | Pelvic infection                                                                   | 10058674    | FALSE   |
		# | Penile infection                                                                   | 10061912    | FALSE   |
		# | Periorbital infection                                                              | 10051472    | FALSE   |
		# | Peripheral nerve infection                                                         | 10065766    | FALSE   |
		# | Peritoneal infection                                                               | 10057262    | FALSE   |
		# | Pharyngitis                                                                        | 10034835    | FALSE   |
		# | Phlebitis infective                                                                | 10056627    | FALSE   |
		# | Pleural infection                                                                  | 10061351    | FALSE   |
		# | Prostate infection                                                                 | 10050662    | FALSE   |
		# | Rash pustular                                                                      | 10037888    | FALSE   |
		# | Rhinitis infective                                                                 | 10059827    | FALSE   |
		# | Salivary gland infection                                                           | 10039413    | FALSE   |
		# | Scrotal infection                                                                  | 10062156    | FALSE   |
		# | Sepsis                                                                             | 10040047    | FALSE   |
		# | Sinusitis                                                                          | 10040753    | FALSE   |
		# | Skin infection                                                                     | 10040872    | FALSE   |
		# | Small intestine infection                                                          | 10065771    | FALSE   |
		# | Soft tissue infection                                                              | 10062255    | FALSE   |
		# | Splenic infection                                                                  | 10062112    | FALSE   |
		# | Stoma site infection                                                               | 10064505    | FALSE   |
		# | Tooth infection                                                                    | 10048762    | FALSE   |
		# | Tracheitis                                                                         | 10044302    | FALSE   |
		# | Upper respiratory infection                                                        | 10046300    | FALSE   |
		# | Urethral infection                                                                 | 10052298    | FALSE   |
		# | Urinary tract infection                                                            | 10046571    | FALSE   |
		# | Uterine infection                                                                  | 10062233    | FALSE   |
		# | Vaginal infection                                                                  | 10046914    | FALSE   |
		# | Vulval infection                                                                   | 10065772    | FALSE   |
		# | Wound infection                                                                    | 10048038    | FALSE   |
		# | Infections and infestations - Other specify                                        | 10021881    | TRUE    |
		# | Ankle fracture                                                                     | 10002544    | FALSE   |
		# | Aortic injury                                                                      | 10002899    | FALSE   |
		# | Arterial injury                                                                    | 10003162    | FALSE   |
		# | Biliary anastomotic leak                                                           | 10050458    | FALSE   |
		# | Bladder anastomotic leak                                                           | 10065802    | FALSE   |
		# | Bruising                                                                           | 10006504    | FALSE   |
		# | Burn                                                                               | 10006634    | FALSE   |
		# | Dermatitis radiation                                                               | 10061103    | FALSE   |
		# | Esophageal anastomotic leak                                                        | 10065961    | FALSE   |
		# | Fall                                                                               | 10016173    | FALSE   |
		# | Fallopian tube anastomotic leak                                                    | 10065788    | FALSE   |
		# | Fallopian tube perforation                                                         | 10065790    | FALSE   |
		# | Fracture                                                                           | 10017076    | FALSE   |
		# | Gastric anastomotic leak                                                           | 10065893    | FALSE   |
		# | Gastrointestinal anastomotic leak                                                  | 10065879    | FALSE   |
		# | Gastrointestinal stoma necrosis                                                    | 10065712    | FALSE   |
		# | Hip fracture                                                                       | 10020100    | FALSE   |
		# | Injury to carotid artery                                                           | 10022161    | FALSE   |
		# | Injury to inferior vena cava                                                       | 10022213    | FALSE   |
		# | Injury to jugular vein                                                             | 10065849    | FALSE   |
		# | Injury to superior vena cava                                                       | 10022356    | FALSE   |
		# | Intestinal stoma leak                                                              | 10059095    | FALSE   |
		# | Intestinal stoma obstruction                                                       | 10059094    | FALSE   |
		# | Intestinal stoma site bleeding                                                     | 10049468    | FALSE   |
		# | Intraoperative arterial injury                                                     | 10065826    | FALSE   |
		# | Intraoperative breast injury                                                       | 10065831    | FALSE   |
		# | Intraoperative cardiac injury                                                      | 10065843    | FALSE   |
		# | Intraoperative ear injury                                                          | 10065844    | FALSE   |
		# | Intraoperative endocrine injury                                                    | 10065834    | FALSE   |
		# | Intraoperative gastrointestinal injury                                             | 10065825    | FALSE   |
		# | Intraoperative head and neck injury                                                | 10065842    | FALSE   |
		# | Intraoperative hemorrhage                                                          | 10055298    | FALSE   |
		# | Intraoperative hepatobiliary injury                                                | 10065827    | FALSE   |
		# | Intraoperative musculoskeletal injury                                              | 10065829    | FALSE   |
		# | Intraoperative neurological injury                                                 | 10065830    | FALSE   |
		# | Intraoperative ocular injury                                                       | 10065841    | FALSE   |
		# | Intraoperative renal injury                                                        | 10065845    | FALSE   |
		# | Intraoperative reproductive tract injury                                           | 10065840    | FALSE   |
		# | Intraoperative respiratory injury                                                  | 10065832    | FALSE   |
		# | Intraoperative skin injury                                                         | 10065846    | FALSE   |
		# | Intraoperative splenic injury                                                      | 10065847    | FALSE   |
		# | Intraoperative urinary injury                                                      | 10065828    | FALSE   |
		# | Intraoperative venous injury                                                       | 10065848    | FALSE   |
		# | Kidney anastomotic leak                                                            | 10065803    | FALSE   |
		# | Large intestinal anastomotic leak                                                  | 10065891    | FALSE   |
		# | Pancreatic anastomotic leak                                                        | 10050457    | FALSE   |
		# | Pharyngeal anastomotic leak                                                        | 10065705    | FALSE   |
		# | Postoperative hemorrhage                                                           | 10055322    | FALSE   |
		# | Postoperative thoracic procedure complication                                      | 10056745    | FALSE   |
		# | Prolapse of intestinal stoma                                                       | 10065745    | FALSE   |
		# | Prolapse of urostomy                                                               | 10065822    | FALSE   |
		# | Radiation recall reaction (dermatologic)                                           | 10037767    | FALSE   |
		# | Rectal anastomotic leak                                                            | 10065894    | FALSE   |
		# | Seroma                                                                             | 10040102    | FALSE   |
		# | Small intestinal anastomotic leak                                                  | 10065892    | FALSE   |
		# | Spermatic cord anastomotic leak                                                    | 10065897    | FALSE   |
		# | Spinal fracture                                                                    | 10041569    | FALSE   |
		# | Stenosis of gastrointestinal stoma                                                 | 10065898    | FALSE   |
		# | Stomal ulcer                                                                       | 10042127    | FALSE   |
		# | Tracheal hemorrhage                                                                | 10062548    | FALSE   |
		# | Tracheal obstruction                                                               | 10044291    | FALSE   |
		# | Tracheostomy site bleeding                                                         | 10065749    | FALSE   |
		# | Ureteric anastomotic leak                                                          | 10065814    | FALSE   |
		# | Urethral anastomotic leak                                                          | 10065815    | FALSE   |
		# | Urostomy leak                                                                      | 10065882    | FALSE   |
		# | Urostomy obstruction                                                               | 10065883    | FALSE   |
		# | Urostomy site bleeding                                                             | 10065748    | FALSE   |
		# | Urostomy stenosis                                                                  | 10065885    | FALSE   |
		# | Uterine anastomotic leak                                                           | 10065886    | FALSE   |
		# | Uterine perforation                                                                | 10046810    | FALSE   |
		# | Vaginal anastomotic leak                                                           | 10065887    | FALSE   |
		# | Vas deferens anastomotic leak                                                      | 10065888    | FALSE   |
		# | Vascular access complication                                                       | 10062169    | FALSE   |
		# | Venous injury                                                                      | 10047228    | FALSE   |
		# | Wound complication                                                                 | 10053692    | FALSE   |
		# | Wound dehiscence                                                                   | 10048031    | FALSE   |
		# | Wrist fracture                                                                     | 10048049    | FALSE   |
		# | Injury poisoning and procedural complications - Other specify                      | 10022117    | TRUE    |
		# | Activated partial thromboplastin time prolonged                                    | 10000636    | FALSE   |
		# | Alanine aminotransferase increased                                                 | 10001551    | FALSE   |
		# | Alkaline phosphatase increased                                                     | 10001675    | FALSE   |
		# | Aspartate aminotransferase increased                                               | 10003481    | FALSE   |
		# | Blood antidiuretic hormone abnormal                                                | 10005332    | FALSE   |
		# | Blood bilirubin increased                                                          | 10005364    | FALSE   |
		# | Blood corticotrophin decreased                                                     | 10005452    | FALSE   |
		# | Blood gonadotrophin abnormal                                                       | 10005561    | FALSE   |
		# | Blood prolactin abnormal                                                           | 10005778    | FALSE   |
		# | Carbon monoxide diffusing capacity decreased                                       | 10065906    | FALSE   |
		# | Cardiac troponin I increased                                                       | 10007612    | FALSE   |
		# | Cardiac troponin T increased                                                       | 10007613    | FALSE   |
		# | CD4 lymphocytes decreased                                                          | 10007839    | FALSE   |
		# | Cholesterol high                                                                   | 10008661    | FALSE   |
		# | CPK increased                                                                      | 10011268    | FALSE   |
		# | Creatinine increased                                                               | 10011368    | FALSE   |
		# | Ejection fraction decreased                                                        | 10050528    | FALSE   |
		# | Electrocardiogram QT corrected interval prolonged                                  | 10014383    | FALSE   |
		# | Fibrinogen decreased                                                               | 10016596    | FALSE   |
		# | Forced expiratory volume decreased                                                 | 10016987    | FALSE   |
		# | GGT increased                                                                      | 10056910    | FALSE   |
		# | Growth hormone abnormal                                                            | 10018748    | FALSE   |
		# | Haptoglobin decreased                                                              | 10019150    | FALSE   |
		# | Hemoglobin increased                                                               | 10055599    | FALSE   |
		# | INR increased                                                                      | 10022402    | FALSE   |
		# | Lipase increased                                                                   | 10024574    | FALSE   |
		# | Lymphocyte count decreased                                                         | 10025256    | FALSE   |
		# | Lymphocyte count increased                                                         | 10025258    | FALSE   |
		# | Neutrophil count decreased                                                         | 10029366    | FALSE   |
		# | Pancreatic enzymes decreased                                                       | 10062646    | FALSE   |
		# | Platelet count decreased                                                           | 10035528    | FALSE   |
		# | Serum amylase increased                                                            | 10040139    | FALSE   |
		# | Urine output decreased                                                             | 10059895    | FALSE   |
		# | Vital capacity abnormal                                                            | 10047580    | FALSE   |
		# | Weight gain                                                                        | 10047896    | FALSE   |
		# | Weight loss                                                                        | 10047900    | FALSE   |
		# | White blood cell decreased                                                         | 10049182    | FALSE   |
		# | Investigations - Other specify                                                     | 10022891    | TRUE    |
		# | Acidosis                                                                           | 10000486    | FALSE   |
		# | Alcohol intolerance                                                                | 10001598    | FALSE   |
		# | Alkalosis                                                                          | 10001680    | FALSE   |
		# | Anorexia                                                                           | 10002646    | FALSE   |
		# | Dehydration                                                                        | 10012174    | FALSE   |
		# | Glucose intolerance                                                                | 10052426    | FALSE   |
		# | Hypercalcemia                                                                      | 10020587    | FALSE   |
		# | Hyperglycemia                                                                      | 10020639    | FALSE   |
		# | Hyperkalemia                                                                       | 10020647    | FALSE   |
		# | Hypermagnesemia                                                                    | 10020670    | FALSE   |
		# | Hypernatremia                                                                      | 10020680    | FALSE   |
		# | Hypertriglyceridemia                                                               | 10020870    | FALSE   |
		# | Hyperuricemia                                                                      | 10020907    | FALSE   |
		# | Hypoalbuminemia                                                                    | 10020943    | FALSE   |
		# | Hypocalcemia                                                                       | 10020949    | FALSE   |
		# | Hypoglycemia                                                                       | 10021005    | FALSE   |
		# | Hypokalemia                                                                        | 10021018    | FALSE   |
		# | Hypomagnesemia                                                                     | 10021028    | FALSE   |
		# | Hyponatremia                                                                       | 10021038    | FALSE   |
		# | Hypophosphatemia                                                                   | 10021059    | FALSE   |
		# | Iron overload                                                                      | 10065973    | FALSE   |
		# | Obesity                                                                            | 10029883    | FALSE   |
		# | Tumor lysis syndrome                                                               | 10045152    | FALSE   |
		# | Metabolism and nutrition disorders - Other specify                                 | 10027433    | TRUE    |
		# | Abdominal soft tissue necrosis                                                     | 10065775    | FALSE   |
		# | Arthralgia                                                                         | 10003239    | FALSE   |
		# | Arthritis                                                                          | 10003246    | FALSE   |
		# | Avascular necrosis                                                                 | 10066480    | FALSE   |
		# | Back pain                                                                          | 10003988    | FALSE   |
		# | Bone pain                                                                          | 10006002    | FALSE   |
		# | Buttock pain                                                                       | 10048677    | FALSE   |
		# | Chest wall pain                                                                    | 10008496    | FALSE   |
		# | Exostosis                                                                          | 10015688    | FALSE   |
		# | Fibrosis deep connective tissue                                                    | 10065799    | FALSE   |
		# | Flank pain                                                                         | 10016750    | FALSE   |
		# | Generalized muscle weakness                                                        | 10062572    | FALSE   |
		# | Growth suppression                                                                 | 10018761    | FALSE   |
		# | Head soft tissue necrosis                                                          | 10065779    | FALSE   |
		# | Joint effusion                                                                     | 10023215    | FALSE   |
		# | Joint range of motion decreased                                                    | 10048706    | FALSE   |
		# | Joint range of motion decreased cervical spine                                     | 10065796    | FALSE   |
		# | Joint range of motion decreased lumbar spine                                       | 10065800    | FALSE   |
		# | Kyphosis                                                                           | 10023509    | FALSE   |
		# | Lordosis                                                                           | 10024842    | FALSE   |
		# | Muscle weakness left-sided                                                         | 10065780    | FALSE   |
		# | Muscle weakness lower limb                                                         | 10065776    | FALSE   |
		# | Muscle weakness right-sided                                                        | 10065794    | FALSE   |
		# | Muscle weakness trunk                                                              | 10065795    | FALSE   |
		# | Muscle weakness upper limb                                                         | 10065895    | FALSE   |
		# | Musculoskeletal deformity                                                          | 10065783    | FALSE   |
		# | Myalgia                                                                            | 10028411    | FALSE   |
		# | Myositis                                                                           | 10028653    | FALSE   |
		# | Neck pain                                                                          | 10028836    | FALSE   |
		# | Neck soft tissue necrosis                                                          | 10065781    | FALSE   |
		# | Osteonecrosis of jaw                                                               | 10064658    | FALSE   |
		# | Osteoporosis                                                                       | 10031282    | FALSE   |
		# | Pain in extremity                                                                  | 10033425    | FALSE   |
		# | Pelvic soft tissue necrosis                                                        | 10065793    | FALSE   |
		# | Scoliosis                                                                          | 10039722    | FALSE   |
		# | Soft tissue necrosis lower limb                                                    | 10065777    | FALSE   |
		# | Soft tissue necrosis upper limb                                                    | 10065778    | FALSE   |
		# | Superficial soft tissue fibrosis                                                   | 10065798    | FALSE   |
		# | Trismus                                                                            | 10044684    | FALSE   |
		# | Unequal limb length                                                                | 10065738    | FALSE   |
		# | Musculoskeletal and connective tissue disorder -  Other specify                    | 10028395    | TRUE    |
		# | Leukemia secondary to oncology chemotherapy                                        | 10048293    | FALSE   |
		# | Myelodysplastic syndrome                                                           | 10028533    | FALSE   |
		# | Treatment related secondary malignancy                                             | 10049737    | FALSE   |
		# | Tumor pain                                                                         | 10045158    | FALSE   |
		# | Neoplasms benign malignant and unspecified (incl cysts and polyps) - Other specify | 10029104    | TRUE    |
		# | Abducens nerve disorder                                                            | 10053662    | FALSE   |
		# | Accessory nerve disorder                                                           | 10060929    | FALSE   |
		# | Acoustic nerve disorder NOS                                                        | 10000521    | FALSE   |
		# | Akathisia                                                                          | 10001540    | FALSE   |
		# | Amnesia                                                                            | 10001949    | FALSE   |
		# | Aphonia                                                                            | 10002953    | FALSE   |
		# | Arachnoiditis                                                                      | 10003074    | FALSE   |
		# | Ataxia                                                                             | 10003591    | FALSE   |
		# | Brachial plexopathy                                                                | 10065417    | FALSE   |
		# | Central nervous system necrosis                                                    | 10065784    | FALSE   |
		# | Cerebrospinal fluid leakage                                                        | 10008164    | FALSE   |
		# | Cognitive disturbance                                                              | 10009845    | FALSE   |
		# | Concentration impairment                                                           | 10010250    | FALSE   |
		# | Depressed level of consciousness                                                   | 10012373    | FALSE   |
		# | Dizziness                                                                          | 10013573    | FALSE   |
		# | Dysarthria                                                                         | 10013887    | FALSE   |
		# | Dysesthesia                                                                        | 10062872    | FALSE   |
		# | Dysgeusia                                                                          | 10013911    | FALSE   |
		# | Dysphasia                                                                          | 10013951    | FALSE   |
		# | Edema cerebral                                                                     | 10014217    | FALSE   |
		# | Encephalopathy                                                                     | 10014625    | FALSE   |
		# | Extrapyramidal disorder                                                            | 10015832    | FALSE   |
		# | Facial muscle weakness                                                             | 10051272    | FALSE   |
		# | Facial nerve disorder                                                              | 10061457    | FALSE   |
		# | Glossopharyngeal nerve disorder                                                    | 10061185    | FALSE   |
		# | Headache                                                                           | 10019211    | FALSE   |
		# | Hydrocephalus                                                                      | 10020508    | FALSE   |
		# | Hypersomnia                                                                        | 10020765    | FALSE   |
		# | Hypoglossal nerve disorder                                                         | 10061212    | FALSE   |
		# | Intracranial hemorrhage                                                            | 10022763    | FALSE   |
		# | Ischemia cerebrovascular                                                           | 10023030    | FALSE   |
		# | IVth nerve disorder                                                                | 10065836    | FALSE   |
		# | Lethargy                                                                           | 10024264    | FALSE   |
		# | Leukoencephalopathy                                                                | 10024382    | FALSE   |
		# | Memory impairment                                                                  | 10027175    | FALSE   |
		# | Meningismus                                                                        | 10027198    | FALSE   |
		# | Movements involuntary                                                              | 10028041    | FALSE   |
		# | Myelitis                                                                           | 10028524    | FALSE   |
		# | Neuralgia                                                                          | 10029223    | FALSE   |
		# | Nystagmus                                                                          | 10029864    | FALSE   |
		# | Oculomotor nerve disorder                                                          | 10053661    | FALSE   |
		# | Olfactory nerve disorder                                                           | 10056388    | FALSE   |
		# | Paresthesia                                                                        | 10033987    | FALSE   |
		# | Peripheral motor neuropathy                                                        | 10034580    | FALSE   |
		# | Peripheral sensory neuropathy                                                      | 10034620    | FALSE   |
		# | Phantom pain                                                                       | 10056238    | FALSE   |
		# | Presyncope                                                                         | 10036653    | FALSE   |
		# | Pyramidal tract syndrome                                                           | 10063636    | FALSE   |
		# | Radiculitis                                                                        | 10061928    | FALSE   |
		# | Recurrent laryngeal nerve palsy                                                    | 10038130    | FALSE   |
		# | Reversible posterior leukoencephalopathy syndrome                                  | 10063761    | FALSE   |
		# | Seizure                                                                            | 10039906    | FALSE   |
		# | Sinus pain                                                                         | 10040747    | FALSE   |
		# | Somnolence                                                                         | 10041349    | FALSE   |
		# | Spasticity                                                                         | 10041416    | FALSE   |
		# | Stroke                                                                             | 10042244    | FALSE   |
		# | Syncope                                                                            | 10042772    | FALSE   |
		# | Transient ischemic attacks                                                         | 10044391    | FALSE   |
		# | Tremor                                                                             | 10044565    | FALSE   |
		# | Trigeminal nerve disorder                                                          | 10060890    | FALSE   |
		# | Vagus nerve disorder                                                               | 10061403    | FALSE   |
		# | Vasovagal reaction                                                                 | 10047166    | FALSE   |
		# | Nervous system disorders - Other specify                                           | 10029205    | TRUE    |
		# | Fetal death                                                                        | 10016479    | FALSE   |
		# | Fetal growth retardation                                                           | 10054746    | FALSE   |
		# | Premature delivery                                                                 | 10036595    | FALSE   |
		# | Unintended pregnancy                                                               | 10045542    | FALSE   |
		# | Pregnancy puerperium and perinatal conditions - Other specify                      | 10036585    | TRUE    |
		# | Agitation                                                                          | 10001497    | FALSE   |
		# | Anorgasmia                                                                         | 10002652    | FALSE   |
		# | Anxiety                                                                            | 10002855    | FALSE   |
		# | Confusion                                                                          | 10010300    | FALSE   |
		# | Delayed orgasm                                                                     | 10057066    | FALSE   |
		# | Delirium                                                                           | 10012218    | FALSE   |
		# | Delusions                                                                          | 10012260    | FALSE   |
		# | Depression                                                                         | 10012378    | FALSE   |
		# | Euphoria                                                                           | 10015533    | FALSE   |
		# | Hallucinations                                                                     | 10019077    | FALSE   |
		# | Insomnia                                                                           | 10022437    | FALSE   |
		# | Libido decreased                                                                   | 10024419    | FALSE   |
		# | Libido increased                                                                   | 10024421    | FALSE   |
		# | Mania                                                                              | 10026749    | FALSE   |
		# | Personality change                                                                 | 10034719    | FALSE   |
		# | Psychosis                                                                          | 10037234    | FALSE   |
		# | Restlessness                                                                       | 10038743    | FALSE   |
		# | Suicidal ideation                                                                  | 10042458    | FALSE   |
		# | Suicide attempt                                                                    | 10042464    | FALSE   |
		# | Psychiatric disorders - Other specify                                              | 10037175    | TRUE    |
		# | Acute kidney injury                                                                | 10069339    | FALSE   |
		# | Bladder perforation                                                                | 10063575    | FALSE   |
		# | Bladder spasm                                                                      | 10048994    | FALSE   |
		# | Chronic kidney disease                                                             | 10064848    | FALSE   |
		# | Cystitis noninfective                                                              | 10063057    | FALSE   |
		# | Hematuria                                                                          | 10019450    | FALSE   |
		# | Hemoglobinuria                                                                     | 10019489    | FALSE   |
		# | Proteinuria                                                                        | 10037032    | FALSE   |
		# | Renal calculi                                                                      | 10038385    | FALSE   |
		# | Renal colic                                                                        | 10038419    | FALSE   |
		# | Renal hemorrhage                                                                   | 10038463    | FALSE   |
		# | Urinary fistula                                                                    | 10065368    | FALSE   |
		# | Urinary frequency                                                                  | 10046539    | FALSE   |
		# | Urinary incontinence                                                               | 10046543    | FALSE   |
		# | Urinary retention                                                                  | 10046555    | FALSE   |
		# | Urinary tract obstruction                                                          | 10061574    | FALSE   |
		# | Urinary tract pain                                                                 | 10062225    | FALSE   |
		# | Urinary urgency                                                                    | 10046593    | FALSE   |
		# | Urine discoloration                                                                | 10046628    | FALSE   |
		# | Renal and urinary disorders - Other specify                                        | 10038359    | TRUE    |
		# | Azoospermia                                                                        | 10003883    | FALSE   |
		# | Breast atrophy                                                                     | 10006179    | FALSE   |
		# | Breast pain                                                                        | 10006298    | FALSE   |
		# | Dysmenorrhea                                                                       | 10013934    | FALSE   |
		# | Dyspareunia                                                                        | 10013941    | FALSE   |
		# | Ejaculation disorder                                                               | 10014326    | FALSE   |
		# | Erectile dysfunction                                                               | 10061461    | FALSE   |
		# | Fallopian tube obstruction                                                         | 10065789    | FALSE   |
		# | Fallopian tube stenosis                                                            | 10065791    | FALSE   |
		# | Female genital tract fistula                                                       | 10061149    | FALSE   |
		# | Feminization acquired                                                              | 10054382    | FALSE   |
		# | Genital edema                                                                      | 10018146    | FALSE   |
		# | Gynecomastia                                                                       | 10018801    | FALSE   |
		# | Hematosalpinx                                                                      | 10060602    | FALSE   |
		# | Irregular menstruation                                                             | 10022992    | FALSE   |
		# | Lactation disorder                                                                 | 10061261    | FALSE   |
		# | Menorrhagia                                                                        | 10027313    | FALSE   |
		# | Nipple deformity                                                                   | 10065823    | FALSE   |
		# | Oligospermia                                                                       | 10030300    | FALSE   |
		# | Ovarian hemorrhage                                                                 | 10065763    | FALSE   |
		# | Ovarian rupture                                                                    | 10033279    | FALSE   |
		# | Ovulation pain                                                                     | 10033314    | FALSE   |
		# | Pelvic floor muscle weakness                                                       | 10064026    | FALSE   |
		# | Pelvic pain                                                                        | 10034263    | FALSE   |
		# | Penile pain                                                                        | 10034310    | FALSE   |
		# | Perineal pain                                                                      | 10061339    | FALSE   |
		# | Premature menopause                                                                | 10036601    | FALSE   |
		# | Prostatic hemorrhage                                                               | 10055325    | FALSE   |
		# | Prostatic obstruction                                                              | 10055026    | FALSE   |
		# | Prostatic pain                                                                     | 10036968    | FALSE   |
		# | Scrotal pain                                                                       | 10039757    | FALSE   |
		# | Spermatic cord hemorrhage                                                          | 10065762    | FALSE   |
		# | Spermatic cord obstruction                                                         | 10065805    | FALSE   |
		# | Testicular disorder                                                                | 10043306    | FALSE   |
		# | Testicular hemorrhage                                                              | 10055347    | FALSE   |
		# | Testicular pain                                                                    | 10043345    | FALSE   |
		# | Uterine fistula                                                                    | 10065811    | FALSE   |
		# | Uterine hemorrhage                                                                 | 10046789    | FALSE   |
		# | Uterine obstruction                                                                | 10065928    | FALSE   |
		# | Uterine pain                                                                       | 10046809    | FALSE   |
		# | Vaginal discharge                                                                  | 10046901    | FALSE   |
		# | Vaginal dryness                                                                    | 10046904    | FALSE   |
		# | Vaginal fistula                                                                    | 10065813    | FALSE   |
		# | Vaginal hemorrhage                                                                 | 10046912    | FALSE   |
		# | Vaginal inflammation                                                               | 10046916    | FALSE   |
		# | Vaginal obstruction                                                                | 10065817    | FALSE   |
		# | Vaginal pain                                                                       | 10046937    | FALSE   |
		# | Vaginal perforation                                                                | 10065818    | FALSE   |
		# | Vaginal stricture                                                                  | 10053496    | FALSE   |
		# | Vaginismus                                                                         | 10046947    | FALSE   |
		# | Reproductive system and breast disorders - Other specify                           | 10038604    | TRUE    |
		# | Adult respiratory distress syndrome                                                | 10001409    | FALSE   |
		# | Allergic rhinitis                                                                  | 10001723    | FALSE   |
		# | Apnea                                                                              | 10002972    | FALSE   |
		# | Aspiration                                                                         | 10003504    | FALSE   |
		# | Atelectasis                                                                        | 10003598    | FALSE   |
		# | Bronchial fistula                                                                  | 10006437    | FALSE   |
		# | Bronchial obstruction                                                              | 10006440    | FALSE   |
		# | Bronchial stricture                                                                | 10063524    | FALSE   |
		# | Bronchopleural fistula                                                             | 10053481    | FALSE   |
		# | Bronchopulmonary hemorrhage                                                        | 10065746    | FALSE   |
		# | Bronchospasm                                                                       | 10006482    | FALSE   |
		# | Chylothorax                                                                        | 10051228    | FALSE   |
		# | Cough                                                                              | 10011224    | FALSE   |
		# | Dyspnea                                                                            | 10013963    | FALSE   |
		# | Epistaxis                                                                          | 10015090    | FALSE   |
		# | Hiccups                                                                            | 10020039    | FALSE   |
		# | Hoarseness                                                                         | 10020201    | FALSE   |
		# | Hypoxia                                                                            | 10021143    | FALSE   |
		# | Laryngeal edema                                                                    | 10023838    | FALSE   |
		# | Laryngeal fistula                                                                  | 10065786    | FALSE   |
		# | Laryngeal hemorrhage                                                               | 10065759    | FALSE   |
		# | Laryngeal inflammation                                                             | 10065735    | FALSE   |
		# | Laryngeal mucositis                                                                | 10065880    | FALSE   |
		# | Laryngeal obstruction                                                              | 10059639    | FALSE   |
		# | Laryngeal stenosis                                                                 | 10023862    | FALSE   |
		# | Laryngopharyngeal dysesthesia                                                      | 10062667    | FALSE   |
		# | Laryngospasm                                                                       | 10023891    | FALSE   |
		# | Mediastinal hemorrhage                                                             | 10056356    | FALSE   |
		# | Nasal congestion                                                                   | 10028735    | FALSE   |
		# | Pharyngeal fistula                                                                 | 10034825    | FALSE   |
		# | Pharyngeal hemorrhage                                                              | 10055315    | FALSE   |
		# | Pharyngeal mucositis                                                               | 10065881    | FALSE   |
		# | Pharyngeal necrosis                                                                | 10065706    | FALSE   |
		# | Pharyngeal stenosis                                                                | 10050028    | FALSE   |
		# | Pharyngolaryngeal pain                                                             | 10034844    | FALSE   |
		# | Pleural effusion                                                                   | 10035598    | FALSE   |
		# | Pleural hemorrhage                                                                 | 10055319    | FALSE   |
		# | Pleuritic pain                                                                     | 10035623    | FALSE   |
		# | Pneumonitis                                                                        | 10035742    | FALSE   |
		# | Pneumothorax                                                                       | 10035759    | FALSE   |
		# | Postnasal drip                                                                     | 10036402    | FALSE   |
		# | Productive cough                                                                   | 10036790    | FALSE   |
		# | Pulmonary edema                                                                    | 10037375    | FALSE   |
		# | Pulmonary fibrosis                                                                 | 10037383    | FALSE   |
		# | Pulmonary fistula                                                                  | 10065873    | FALSE   |
		# | Pulmonary hypertension                                                             | 10037400    | FALSE   |
		# | Respiratory failure                                                                | 10038695    | FALSE   |
		# | Retinoic acid syndrome                                                             | 10038921    | FALSE   |
		# | Sinus disorder                                                                     | 10062244    | FALSE   |
		# | Sleep apnea                                                                        | 10040975    | FALSE   |
		# | Sneezing                                                                           | 10041232    | FALSE   |
		# | Sore throat                                                                        | 10041367    | FALSE   |
		# | Stridor                                                                            | 10042241    | FALSE   |
		# | Tracheal fistula                                                                   | 10065787    | FALSE   |
		# | Tracheal mucositis                                                                 | 10065900    | FALSE   |
		# | Tracheal stenosis                                                                  | 10050816    | FALSE   |
		# | Voice alteration                                                                   | 10047681    | FALSE   |
		# | Wheezing                                                                           | 10047924    | FALSE   |
		# | Respiratory thoracic and mediastinal disorders - Other  specify                    | 10038738    | TRUE    |
		# | Alopecia                                                                           | 10001760    | FALSE   |
		# | Body odor                                                                          | 10005901    | FALSE   |
		# | Bullous dermatitis                                                                 | 10006556    | FALSE   |
		# | Dry skin                                                                           | 10013786    | FALSE   |
		# | Erythema multiforme                                                                | 10015218    | FALSE   |
		# | Erythroderma                                                                       | 10015277    | FALSE   |
		# | Fat atrophy                                                                        | 10016241    | FALSE   |
		# | Hirsutism                                                                          | 10020112    | FALSE   |
		# | Hyperhidrosis                                                                      | 10020642    | FALSE   |
		# | Hypertrichosis                                                                     | 10020864    | FALSE   |
		# | Hypohidrosis                                                                       | 10021013    | FALSE   |
		# | Lipohypertrophy                                                                    | 10062315    | FALSE   |
		# | Nail discoloration                                                                 | 10028691    | FALSE   |
		# | Nail loss                                                                          | 10049281    | FALSE   |
		# | Nail ridging                                                                       | 10062283    | FALSE   |
		# | Pain of skin                                                                       | 10033474    | FALSE   |
		# | Palmar-plantar erythrodysesthesia syndrome                                         | 10054524    | FALSE   |
		# | Periorbital edema                                                                  | 10054541    | FALSE   |
		# | Photosensitivity                                                                   | 10034966    | FALSE   |
		# | Pruritus                                                                           | 10037087    | FALSE   |
		# | Purpura                                                                            | 10037549    | FALSE   |
		# | Rash acneiform                                                                     | 10037847    | FALSE   |
		# | Rash maculo-papular                                                                | 10037868    | FALSE   |
		# | Scalp pain                                                                         | 10049120    | FALSE   |
		# | Skin atrophy                                                                       | 10040799    | FALSE   |
		# | Skin hyperpigmentation                                                             | 10040865    | FALSE   |
		# | Skin hypopigmentation                                                              | 10040868    | FALSE   |
		# | Skin induration                                                                    | 10051837    | FALSE   |
		# | Skin ulceration                                                                    | 10040947    | FALSE   |
		# | Stevens-Johnson syndrome                                                           | 10042033    | FALSE   |
		# | Telangiectasia                                                                     | 10043189    | FALSE   |
		# | Toxic epidermal necrolysis                                                         | 10044223    | FALSE   |
		# | Urticaria                                                                          | 10046735    | FALSE   |
		# | Skin and subcutaneous tissue disorders - Other specify                             | 10040785    | TRUE    |
		# | Menopause                                                                          | 10027308    | FALSE   |
		# | Social circumstances - Other specify                                               | 10041244    | TRUE    |
		# | Surgical and medical procedures - Other specify                                    | 10042613    | TRUE    |
		# | Capillary leak syndrome                                                            | 10007196    | FALSE   |
		# | Flushing                                                                           | 10016825    | FALSE   |
		# | Hematoma                                                                           | 10019428    | FALSE   |
		# | Hot flashes                                                                        | 10020407    | FALSE   |
		# | Hypertension                                                                       | 10020772    | FALSE   |
		# | Hypotension                                                                        | 10021097    | FALSE   |
		# | Lymph leakage                                                                      | 10065773    | FALSE   |
		# | Lymphedema                                                                         | 10025233    | FALSE   |
		# | Lymphocele                                                                         | 10048642    | FALSE   |
		# | Peripheral ischemia                                                                | 10034578    | FALSE   |
		# | Phlebitis                                                                          | 10034879    | FALSE   |
		# | Superficial thrombophlebitis                                                       | 10042554    | FALSE   |
		# | Superior vena cava syndrome                                                        | 10042569    | FALSE   |
		# | Thromboembolic event                                                               | 10043565    | FALSE   |
		# | Vasculitis                                                                         | 10047115    | FALSE   |
		# | Visceral arterial ischemia                                                         | 10054692    | FALSE   |
		# | Vascular disorders - Other specify                                                 | 10047065    | TRUE    |
	# And Data Dictionary "TOX_RL" has entries
		# | User Value | Coded Value |
		# | Unrelated  | 1           |
		# | Unlikely   | 2           |
		# | Possible   | 3           |
		# | Probable   | 4           |
		# | Definite   | 5           |
	# And Data Dictionary "YESNO" has entries
		# | User Value | Coded Value |
		# | Yes        | 1           |
		# | No         | 2           |
	# And Data Dictionary "OTHAE" has entries
		# | User Value                                     | Coded Value |
		# | Yes, and reportable adverse events occurred    | 1           |
		# | Yes, but no reportable adverse events occurred | 2           |
		# | No                                             | 3           |
	# And Field "VALXX" on Form "Adverse Event Form" has Edit Check "DSL_TOXICITY_REQDACTMON_GradeLookup" using Custom Function "DSL_TOXICITY_SOLICIT_GradeLookup"
	# And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "L1WP-GT" for Enviroment "Prod"
	# And there is a custom table "c_CTCAE_Lookup_GRADES_WR103437" on the database
		
	# DSL_TOXICITY_REQDACTMON_GradeLookup Custom Function:
	# SELECT Grade_Code, Grade_Code
	# FROM c_CTCAE_Lookup_GRADES_WR103437
	# WHERE MedDRA_Code='{text='datapoint.standardvalue' fieldoid='TOXXX'}' AND CTCAE_Version = 4.03

	# DSL_TOXICITY_REQDACTMON_GradeLookup Edit Check:
	# Check Steps:
	# Data Value: Adverse Event Form>TOXXX>TOXXX
	# Check Function: IsPresent
	# Data Value: Adverse Event Form>VALXX>VALSOL
	# Check Function: IsPresent
	# Check Function: Or
	# Check Actions: 
	# Datapoint: Adverse Event Form>VALXX>VALSOL
	# Action: Set DynamicSearchList: DSL_TOXICITY_REQDACTMON_GradeLookup

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB_US13002_DT13919_01
@PM_Review
Scenario: @PB_US13002_DT13919_01 As a Study Coordinator, when I click the drop-down list to see matching results, then matching results are displayed within 3 seconds.
	
	And I select Study "L1WP-GT" and Site "Site 1"
	And I create a Subject
		| Field						| Data              |
		| Datacenter ID				| {RndNum<num1>(5)} |
		| Subject Initials (F M L)	| SUB               |
	And I select Form "Adverse Event Form"
	And I take a screenshot
	When I click drop button on dynamic search list "Adverse Event Grade" in log line 1
	And I wait for 3 seconds
	Then I should see dynamic search list "Adverse Event Grade" in log line 1 open
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB_US13002_DT13919_02
@PM_Review
Scenario: @PB_US13002_DT13919_02 As a Study Coordinator, when I enter data into a Dynamic Search List field on a log form, and I see matching results are displayed within 3 seconds.
	
	Given I select Study "L1WP-GT" and Site "Site 1"
	When I create a Subject
		| Field						| Data              |
		| Datacenter ID				| {RndNum<num1>(5)} |
		| Subject Initials (F M L)	| SUB               |
	And I select Form "Adverse Event Form"
	And I take a screenshot
	And I enter "3" on dynamic search list "Adverse Event Grade" in log line 1
	And I wait for 3 seconds
	Then I should see dynamic search list "Adverse Event Grade" in log line 1 open
	And I take a screenshot
	And I navigate to "Home"
	And I accept alert window
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB_US13002_DT13919_03
@PM_Review
Scenario: @PB_US13002_DT13919_03 As a Study Coordinator, when I enter data into a Dynamic Search List field on a log form, and I see matching results are displayed within 3 seconds.
And I select Study "L1WP-GT" and Site "Site 1"
And I create a Subject
| Field	| Data              |
| Datacenter ID	| {RndNum<num1>(5)} |
| Subject Initials (F M L)	| SUB               |
And I select Form "Adverse Event Form"

#Note: Instead of Enter, can we have select data from DSL list or we should have both step defs?
#And I enter "3" on dynamic search list "Adverse Event Grade" in log line 1
#And I select "3" on dynamic search list "Adverse Event Grade" in log line 1

And I enter "3" on dynamic search list "Adverse Event Grade" in log line 1
And I enter "" on dynamic search list "Adverse Event Grade" in log line 2
And I enter "" on dynamic search list "Adverse Event Grade" in log line 3
And I enter "5" on dynamic search list "Adverse Event Grade" in log line 4
And I enter "0" on dynamic search list "Adverse Event Grade" in log line 5	
And I save the CRF page
And I take a screenshot
And I open log line 3
When I click drop button on dynamic search list "Adverse Event Grade" in log line 3
And I wait for 3 seconds
Then I should see dynamic search list "Adverse Event Grade" in log line 3 open
And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB_US13002_DT13919_04
@PM_Review
Scenario: @PB_US13002_DT13919_04 As a Study Coordinator, when I click the drop-down list to see matching results in DDE, then matching results are displayed within 3 seconds.
	
	And I navigate to "DDE"
	And I select link "First Pass"
	And I select link "New Batch"
	And I choose "L1WP-GT" from "Study"
	#And I choose "Prod" from "Environment"
	And I choose "Site 13919" from "Site"
	And I type "SUB {RndNum<num1>(5)}" in "Subject"
	And I choose "Subject Enrollment Form" from "Form"
	And I click button "Locate"
	And I enter data in DDE and save
		| Field						| Data              |
		| Datacenter ID				| {RndNum<num1>(5)} |
		| Subject Initials (F M L)	| SUB               |
	And I choose "Adverse Event Form" from "Form"
	And I click button "Locate"
	And I take a screenshot
	When I click drop button on dynamic search list "Adverse Event Grade" in log line 1
	And I wait for 3 seconds
	Then I should see dynamic search list "Adverse Event Grade" in log line 1 open
	And I take a screenshot


#	When I create a Subject
#		| Field						| Data              |
#		| Datacenter ID				| {RndNum<num1>(5)} |
#		| Subject Initials (F M L)	| SUB               |
#	And I select Form "Adverse Event Form"
#	And I take a screenshot
#	And I click drop button on dynamic search list "Adverse Event Grade" in log line 1
#	Then I should see dynamic search list "Adverse Event Grade" in log line 1 open within 3 seconds
#	And I take a screenshot
#	And I add a new log line
#		| Field                                | Data                           | Control Type	|
#		| Adverse Event Text Name (CTCAE v4.0) | Wolff-Parkinson-White syndrome | dropdown		|
#	And I take a screenshot
#	And I click drop button on dynamic search list "Adverse Event Grade" in log line 1
#	Then I should see dynamic search list "Adverse Event Grade" in log line 1 open within 3 seconds
#	And I take a screenshot
#	And I open log line 1
#	And I take a screenshot
#	And I click drop button on dynamic search list "Adverse Event Grade" in log line 1
#	Then I should see dynamic search list "Adverse Event Grade" in log line 1 open within 3 seconds
#	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
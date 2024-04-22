import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const qualifications = [
  "Adv Crit Life Support",
  "Adv Dip Occup Health",
  "Adv Paed Life Support",
  "Adv Trauma Life Support",
  "Arts Examination Hol",
  "Arztliche Prufung",
  "Ass Faculty Occu Med",
  "B Chir Cambridge",
  "B MED SC (HONS)",
  "B Vet Science",
  "B. Dent. Surg. (hon)",
  "BCHD",
  "BDSc",
  "BM",
  "BM BCh",
  "BMED SCIENCE",
  "BMED UNIV PUNJAB",
  "BPHARM",
  "BSURG UNIV PUNJAB",
  "BSc Med Sc Hons (Aerosp Med)",
  "BSc Med Sc Hons (U/water Med)",
  "BSc Oral Biology",
  "BSc(Hons)Aerospace Med",
  "Bachelor Dental Sur.",
  "Board Exam",
  "Bsc (Hons) Med Sc (Rep Biol)",
  "Bsc Lab Med",
  "Cags Orth Boston",
  "Cert Cardiology",
  "Cert Child Psychiatry",
  "Cert Clinical Haematology",
  "Cert Critical Care",
  "Cert Developmental Paediatrics",
  "Cert Endocrinology & Metabol",
  "Cert Endodontics",
  "Cert Family Med",
  "Cert Gastroenterology",
  "Cert Geriatric Medicine",
  "Cert Gyn Oncology",
  "Cert Infectious Diseases",
  "Cert Medical Genetics",
  "Cert Medical Oncology",
  "Cert Neonatology",
  "Cert Nephrology (SA)",
  "Cert Paediatric G / Enterology",
  "Cert Paediatric Neurology",
  "Cert Paediatric Surgery",
  "Cert Pulmonology",
  "Cert Reproductive Medicine",
  "Cert Rheumatology",
  "Cert Trauma Surgery",
  "Cert Vascular Surgery",
  "ChM",
  "Civ",
  "D 0&G",
  "D Gemeenskap Gesondheid",
  "D Mid Cog (SA)",
  "D OPHT RCS",
  "D ORTH RCS",
  "D Obst",
  "D Orth",
  "D PHARM",
  "D PROS (WITS)",
  "D Paed",
  "D Path RCP Lon RCS",
  "D Phys Med",
  "D Sc",
  "D Sc (Odont)",
  "D. Periodont. Oral M",
  "DA (PTA)",
  "DA (SA)",
  "DA (UK)",
  "DA RCPS",
  "DA Wits",
  "DBG",
  "DCH (SA)",
  "DCH RCP",
  "DCHD",
  "DCM",
  "DCM(RCP)",
  "DCP",
  "DCP (London)",
  "DDM  (Dentist)",
  "DDO RCPS",
  "DDPH",
  "DGA",
  "DGA (Dent)",
  "DHA",
  "DIH",
  "DKG (SA)",
  "DLO (Pta)",
  "DLO RCP",
  "DMA",
  "DMC",
  "DMH (SA)",
  "DMR",
  "DMR Edin",
  "DMRD RCP",
  "DMRT RCP",
  "DO RCP & S",
  "DOH",
  "DOH & M",
  "DOM",
  "DOMS RCP&S",
  "DORCP",
  "DPH",
  "DPM RCP (Lon)",
  "DR Edinburgh",
  "DTG",
  "DTM & H",
  "DTVG",
  "DVG",
  "Dip  PNS(SA)",
  "Dip Allerg ( SA )",
  "Dip Clin HIV/AIDS Management",
  "Dip Dent Orthopaedic",
  "Dip Dentistry",
  "Dip Fam Med",
  "Dip For Med (SA)",
  "Dip HIV Management",
  "Dip Health Service Management",
  "Dip Obst (SA)",
  "Dip Odont. (Pret)",
  "Dip Ophth (SA)",
  "Dip PEC",
  "Dip Ven London",
  "Dip Verl KOG (SA)",
  "Dip d'Etat France",
  "Dip in  Clin Path",
  "Dip in Aviation Med",
  "Dip in Forensic Odont",
  "Dip in Geriatric Med UK",
  "Dip in Maxil-facial Ora",
  "Dip in Med",
  "Dip in Obs & Gyn (UK)",
  "Dip in Odontology",
  "Dip in Orth. RCS(Eng",
  "Dip in Palliative Medicine",
  "Dip in Psychological Medicine",
  "Dip in Public Dentistry",
  "Dip in Surg",
  "Dr in Geneeskunde",
  "Dr of Dental Surgery",
  "Dr. of Dentistry",
  "F C Path (Anat)",
  "F Forensic Pathology",
  "F I A C",
  "F PSYCH RCPS CAN",
  "F Psych",
  "F Royal Aust Col Surg",
  "FACC",
  "FACE",
  "FAFP",
  "FANZCA",
  "FC (Cardio) SA",
  "FC Derm (SA)",
  "FC For Path (SA)",
  "FC Neurol ( SA)",
  "FC Neurosurgery (SA)",
  "FC Nucl Med (SA)",
  "FC Ophth",
  "FC Orth (SA)",
  "FC Oto (SA)",
  "FC Paed (SA)",
  "FC Paed Surg (SA)",
  "FC Path (SA) Anat",
  "FC Path (SA) Chem",
  "FC Path (SA) Clinial",
  "FC Path (SA) Haem",
  "FC Path (SA) Micro",
  "FC Path (SA) Viro",
  "FC Plast Surg (SA)",
  "FC Psych (SA)",
  "FC Rad (SA) Diag",
  "FC Rad (SA) Onc",
  "FC Urol (SA)",
  "FCA  (SA)",
  "FCCH (SA)",
  "FCEM (SA)",
  "FCFP (SA)",
  "FCMG (SA)",
  "FCNP (SA)",
  "FCOG (SA)",
  "FCORL (SA)",
  "FCP",
  "FCP (SA)",
  "FCP (SA) Neurol",
  "FCP (SA) Paed",
  "FCPHH (SA) Occ Med",
  "FCPHM (SA)",
  "FCS (SA)",
  "FCS (SA)  (L et O)",
  "FCS (SA) Cardio",
  "FCS (SA) ORL",
  "FCS (SA) Ophthal",
  "FCS (SA) Orth",
  "FCS (SA) Plast & Recon",
  "FCS (SA) Thoracic",
  "FCS (SA) Urology",
  "FDS RCS (ENG)",
  "FF (Rad)",
  "FF CH (SA)",
  "FF Derm (SA)",
  "FF Path (SA)",
  "FF Path (SA) Anat",
  "FF Path (SA) Chem",
  "FF Path (SA) Haem",
  "FF Path (SA) Micro",
  "FF Psych (SA)",
  "FF Rad (D)",
  "FF Rad (T)",
  "FFA (SA)",
  "FFA RCS",
  "FFD",
  "FFD (SA)",
  "FFD (SA) MFOS",
  "FFR",
  "FRACP (New Zealand)",
  "FRC Ophth",
  "FRC Path",
  "FRC Psych",
  "FRC RCP",
  "FRCA (England)",
  "FRCOG",
  "FRCP",
  "FRCP Canada",
  "FRCP London",
  "FRCR",
  "FRCS",
  "FRFPS GLASG",
  "Fellwshp in DS glasg",
  "Foreign",
  "GKC (SA)",
  "GKC (SA) Neuro",
  "GKC (SA) Orl",
  "GKC (SA) Ort",
  "GKC (SA) Urol",
  "GKI (SA)",
  "GKI (SA) Paed",
  "H Dip Int Med (SA)",
  "H Dip Orth (SA)",
  "H Dip Surg ( SA)",
  "Higher Dip. In Dent.",
  "Industrial Medicine",
  "L LM RCP Irel   L LM RCS Irel",
  "L PEDAGOGICS LEUVEN",
  "LAH",
  "LDS Leeds",
  "LDS St Andrews",
  "LF Pat (SA)",
  "LF Psig (SA)",
  "LFAP (SA)",
  "LFN (SA)",
  "LFT (SA)",
  "LKC (SA)",
  "LKC (SA)  (L et O)",
  "LKI (SA)",
  "LKOG (SA)",
  "LM",
  "LMC",
  "LMSSA",
  "LRCP (LONDON)",
  "LRCP Edin",
  "LRCP Ireland",
  "LRCPS Glas",
  "LRCS Edin",
  "LRCS Ireland",
  "LRFPS",
  "Licen of Dent Surg",
  "Licentiate Dent. Sur",
  "M (Dom Med)",
  "M (Med Dom) Pretoria",
  "M Admin Indust Psych",
  "M Com Indust Psychol",
  "M Dent (Medunsa)",
  "M Dent. Sci. Pret.",
  "M ECON",
  "M ED CLIN PSYCHOLOGY",
  "M ED PSIG",
  "M EDUCATIONAL PSYCH",
  "M Fam Med",
  "M I A C",
  "M Obs & Gynaecology",
  "M Prax Med",
  "M Psych",
  "M Sc Clin Psychology",
  "M Sc Counsel Psychology",
  "M Soc Sc Psychology",
  "M Sports Med",
  "MA",
  "MA Clin Psychology",
  "MB",
  "MB BCh",
  "MB BChir",
  "MB BS",
  "MB ChB",
  "MBA",
  "MBCH",
  "MC",
  "MCFP (SA)",
  "MCH",
  "MChD (Community) MED",
  "MD",
  "MD ORTHO",
  "MD UROLOGY",
  "MDIP",
  "MDS (Wits)",
  "MFAP (SA)",
  "MFGP (SA)",
  "MFOM RCP Eng",
  "MFOS",
  "MM Soc Apoth",
  "MMed",
  "MMed (Anaes)",
  "MMed (Anat Path)",
  "MMed (CIV)",
  "MMed (Card Thor Surg)",
  "MMed (Chem Path)",
  "MMed (Chir / Surg)",
  "MMed (Clinical Pathology)",
  "MMed (Comm Health)",
  "MMed (DOM)",
  "MMed (Dermatology)",
  "MMed (Em Med)"
      "MMed (Fam Med)",
  "MMed (Forensic Pathology)",
  "MMed (General Admin)",
  "MMed (Haem Path)",
  "MMed (Huisartskunde)",
  "MMed (Int)",
  "MMed (L et O)",
  "MMed (MED)",
  "MMed (Med Forens)",
  "MMed (Micro Path)",
  "MMed (Neurol)",
  "MMed (Neurosurgery)",
  "MMed (Nuclear Med)",
  "MMed (O&G)",
  "MMed (ONK)",
  "MMed (ORL)",
  "MMed (Occ Medicine)",
  "MMed (Occup & Envir Hlth)",
  "MMed (Ophthalmology)",
  "MMed (Orth)",
  "MMed (Oto)",
  "MMed (Paed)",
  "MMed (Path)",
  "MMed (Phys Med)",
  "MMed (Plast&ReconSurg",
  "MMed (Plastic Surgery)",
  "MMed (Prev Gen)",
  "MMed (Psych)",
  "MMed (Public Health)",
  "MMed (Rad D)",
  "MMed (Rad Oncology)",
  "MMed (Rad T)",
  "MMed (Thoracic Surg)",
  "MMed (Urology)",
  "MMed (Virol Path)",
  "MMed Sci (Sheffield)",
  "MMed Science (Clinical Epidem)",
  "MO & G",
  "MPH",
  "MPharm Med",
  "MPhil (Emer Med)",
  "MPhil (Family Medicine)",
  "MRA CGP",
  "MRC PSYCH",
  "MRC Path",
  "MRC RCP",
  "MRCGP",
  "MRCOG",
  "MRCP (Edin)",
  "MRCP (London)",
  "MRCS (London)",
  "MSC DPH",
  "MSS BRYN",
  "MSc (Dent) Wits.",
  "MSc (Odont) Pretoria",
  "MSc (Orth)",
  "MSc Odont. Stell.",
  "MSc Ophtal",
  "MSc Oral Surg. Lond.",
  "MSc Sports Medicine",
  "MSc(Dent Sciences)",
  "MUDr",
  "Mast. Dentistry Wits",
  "Mast. of Dental sur.",
  "Master of Sc. Dent.",
  "Master of Science",
  "Master of Surgery",
  "National Exam",
  "PDD",
  "PGDip General Ultrasound",
  "PhD",
  "PhD (Med)",
  "PhD DENT.",
  "RCP IRELAND",
  "RCS ENG",
  "SAMDC",
  "SANDC",
  "St Exam Switzerland",
  "State Exam. Germany",
  "Surgeon  FMH (Switz)",
  "TDD",
  "Tandarts (Neth)",
];

const availableUniversities = [
  "Aarhus",
  "Academy of Lublin Poland",
  "Addis Ababa",
  "Agra",
  "Ahmadu Bello",
  "Al - Arab",
  "Al Fateh",
  "Albert Szenk Gyorgi",
  "Alberta",
  "Alexandria",
  "Algiers",
  "Aligarh Muslim",
  "Allahabad",
  "American College of Surgeons",
  "American Univ. of Carribean",
  "Amsterdam",
  "Andhra",
  "Angola Medical School - Luanda",
  "Annamalai",
  "Antwerp",
  "Aquila",
  "Argentina",
  "Aristotelous Univ Greece",
  "Arizona",
  "Arts Exam Netherlands",
  "Ascuncion",
  "Athens",
  "Auckland",
  "Australia",
  "Bahauddin Zakariya",
  "Bahawalpur",
  "Banarab Hindu University India"
      "Banaras",
  "Bangalore",
  "Baroda",
  " Basrah",
  "Beijing",
  "Belfast",
  "Belgrade",
  "Benghazi",
  "Benin",
  "Berhampur",
  "Berlin",
  "Bern",
  "Bhagalpur",
  "Bharathiar",
  "Bhopal",
  "Birmingham",
  "Bologna   Italy",
  "Bombay",
  "Bonn",
  "Boston",
  "Bratislava",
  "Brazzaville",
  "Bristol",
  "British Columbia",
  "Brno",
  "Brussels",
  "Bucharest",
  "Budapest",
  "Buenos Aires",
  "Bundelkhand",
  "Burma",
  "Cairo",
  "Calabar",
  "Calcutta",
  "Calgary",
  "Calicut",
  "California",
  "Camaguey",
  "Cambridge",
  "Cameroon",
  "Canada",
  "Carol Davila",
  "Catania",
  "Catholic University of Louvain",
  "Cebu Med Instit",
  "Cetec",
  "Ceylon Sri-lanka",
  "Charles",
  "Chile",
  "China",
  "Chittagong",
  "Cluj",
  "Coimbra",
  "College of Medicine SA",
  "College of Surgeons England",
  "Cologne",
  "Columbia",
  "Copenhagen",
  "Cordoba",
  "Cracow Univ of Med Polland",
  "Creighton",
  "Dacca",
  "Dar Es Salaam",
  "De Las Villas",
  "De Oriente",
  "De Villa Clara",
  "Delhi",
  "Dem Rep Congo",
  "Devi Ahilya Vishvavidalaya",
  "Dhaka",
  "Dibrugarh",
  "Dublin",
  "Dundee",
  "Durham",
  "Dusseldorf",
  "Edinburgh",
  "Eduardo Modlane",
  "Ege",
  "Emory",
  "England",
  "Erlangen",
  "Essen",
  "Fatima Jinnah",
  "Federico Henriquez Y Carvajal",
  "Foreign",
  "Fort Hare",
  "France",
  "Frankfurt",
  "Geneve",
  "Germany",
  "Ghana",
  "Ghent   Belguim",
  "Glasgow",
  "Goa",
  "Granada",
  "Graz",
  "Guangzhou",
  "Gujarat",
  "Gulbarga",
  "Gulbenge",
  "Guru Nanak",
  "Gutraga Med College India",
  "Guyana",
  "H P C S A",
  "Hacettepe",
  "Hadassah",
  "Hamburg",
  "Hannover",
  "Havana",
  "Heidelberg   Germany",
  "Himachal Pradesh",
  "Holguin",
  "Iasi",
  "Ibadan",
  "Ile-Ife"
      "Illinois",
  "Ilorin",
  "India",
  "Indore",
  "Inst Alma-atta",
  "Inst Crimean",
  "Inst Danetsk",
  "Inst Kalinen",
  "Inst L'vov",
  "Inst Pleven",
  "Inst Sofia",
  "Inst Vinnitsa",
  "Inst Vitebsk",
  "Inst of Medicine Burma",
  "Institute Rostov",
  "Institute Sophia",
  "Institute of Med Mandalay",
  "Ionnina",
  "Ireland",
  "Israel Technical Institute",
  "Istanbul",
  "Jammu",
  "Jerusalem",
  "Jiwaji",
  "Jos",
  "Jundi Shapur",
  "Kakatiya",
  "Kanpur",
  "Kansas",
  "Karachi",
  "Karel",
  "Karnatak Dharwar/india",
  "Karolinska",
  "Kashmir",
  "Kasturba",
  "Kathmandu",
  "Keiv (Russia)",
  "Kerala",
  "Kharkov",
  "Khartoum",
  "Kiel",
  "Kiev",
  "Kinshasa",
  "Kisangani",
  "Korin",
  "Kuban",
  "Kumasi",
  "La Plata",
  "Lagos",
  "Lahore",
  "Leeds University",
  "Leicester",
  "Leiden",
  "Leipzig",
  "Leuven",
  "Liege",
  "Lisbon",
  "Liverpool",
  "Lodz",
  "London",
  "Lourenco Marques",
  "Louvain",
  "Lubumbashi",
  "Lucknow",
  "Lumumba   Moscow",
  "Lund",
  "Madras",
  "Madrid",
  "Madural Kamaraj",
  "Magadh",
  "Maharshi Dayanand",
  "Mahatma Gandhi",
  "Maiduguri",
  "Makerere",
  "Malawi",
  "Manchester University England",
  "Mandaly",
  "Mangalore",
  "Manila",
  "Manipal",
  "Maputo",
  "Marathwada",
  "Marburg",
  "Marseilles",
  "Mbarara",
  "McGill",
  "McMaster",
  "Med Acad Bialystok",
  "Med Acad Bydgoszczy",
  "Med Acad Gdansk Poland",
  "Med Acad Katowice",
  "Med Acad Lublin",
  "Med Acad Poznan",
  "Med Acad Voronech",
  "Med Acad Warsaw",
  "Med Acadamy Szczecin",
  "Med Academy Wroclaw",
  "Med Inst Leningrad",
  "Med Inst Plovdiv",
  "Med Inst Stavropol",
  "Med Krakow",
  "Medical Acadamy of Slaska",
  "Medical Academy Kyrgyzskan",
  "Medical Academy Zabrze",
  "Medical Institute Philippines",
  "Meerut",
  "Michigan",
  "Minsk",
  "Mithila",
  "Montevideo",
  "Moscow",
  "Mozambique",
  "Munchen",
  "Mysore",
  "Nagpur",
  "Nairobi",
  "Naples",
  "Netherlands",
  "New South Wales",
  "Newcastle Upon Tyne",
  "Newcastle on tyne",
  "Nigeria",
  "Nis",
  "Nnamdi Azikiwe",
  "Nottingham",
  "Novi Sad",
  "Nuestra Senora Del Rosario",
  "Obafemi Awolowo Univ Nigeria",
  "Ogun",
  "Oklahoma",
  "Olomouc",
  "Oradea",
  "Oslo",
  "Osmania",
  "Otago",
  "Oviedo",
  "Oxford",
  "Padua",
  "Panjab",
  "Patna",
  "Patras",
  "Pecs",
  "Peradeniya",
  "Peruana Cayetano Heredia",
  "Petrozavodsk",
  "Pisa",
  "Poland",
  "Pondicherry",
  "Poona",
  "Port Harcourt",
  "Porto",
  "Potchefstroom University CHO",
  "Pote Hungray",
  "Prague",
  "Punjab",
  "Qingdao",
  "R C P   U K",
  "R C S London",
  "Rajasthan",
  "Rajshahi",
  "Ranchi",
  "Rand Afrikaans University",
  "Rangoon",
  "Ravishankar",
  "Rhodes Univ Grahamstown",
  "Rhodesia",
  "Riga",
  "Rome",
  "Ross",
  "Royal College Of Gp's",
  "Royal College of Anaesthetists",
  "Royal College of Medicine",
  "Royal College of Obs & Gyn",
  "Royal College of Ophth (UK)",
  "Royal College of Pathologists",
  "Royal College of Psychiatrists",
  "Royal College of Radiologists",
  "Royal College of Surgeons",
  "Rwanda",
  "S/W Univeristy of Phillipines",
  "Saarbrucken",
  "Salahaddin",
  "Sambalpur",
  "San Andres",
  "Santiago de Cuba",
  "Sao Paulo",
  "Sarajevo",
  "Saurashtra",
  "Sheffield",
  "Shivaji",
  "Siena Medical School Italy",
  "Sienna",
  "Sindh",
  "Smolensk",
  "Somalia",
  "South America",
  "South Gujarat",
  "Southhampton",
  "Southwestern",
  "Spartan",
  "Sri Lanka",
  "Sri Venkateswara",
  "St Andrews",
  "St George's",
  "St Joseph",
  "Stom Acad Ukraine",
  "Svezdlovsk",
  "Switzerland",
  "Sydney",
  "Szeged",
  "Tasmania",
  "Tbilisi",
  "Tech-Israel Inst of Technology",
  "Tel-Aviv Medical School Israel",
  "Teshreen",
  "Thailand Mahedol University",
  "Thessalonika",
  "Timisoara",
  "Tokyo",
  "Toronto",
  "Tribhuvan University",
  "Trieste",
  "Tripoli",
  "Tulane",
  "Turin",
  "Turkey",
  "UNISA",
  "Uberaba",
  "Uludag",
  "Unirhemos",
  "United Kingdom",
  "United State of America",
  "Univ  Cape Town",
  "Univ  Free State"
      "Univ  Medunsa/Limpopo/Sefako Makgatho",
  "Univ  Natal",
  "Univ  Nelson Mandela  PE",
  "Univ  Pretoria",
  "Univ  Stellenbosch",
  "Univ  Transkei/Walter Sisulu",
  "Univ  WITS",
  "Univ Bahawalpur Pakistan",
  "Univ Lausanne Switzerland",
  "Univ Melbourne Australia",
  "Univ Of Groningen Holland",
  "Univ Of Lubumbashi Drc",
  "Univ Of Mbuji Mayi D R C",
  "Univ Of The Netherlands",
  "Univ Stockholm",
  "Universitaire France",
  "Universite National du Zaire",
  "University Of Aberdeen",
  "University Of Massachusetts",
  "University Of Teheran",
  "University de Cuba",
  "University of Bolivia",
  "University of Buffalo",
  "University of Crete Greece",
  "University of Czechoslovakia",
  "University of Gent",
  "University of Innsbruck",
  "University of Lagos  Nigeria",
  "University of Maryland USA",
  "University of Med & Ph Romania",
  "University of Milan",
  "University of Munster",
  "University of New York",
  "University of New Zealand",
  "University of Pavia Italy",
  "University of Pennsylvania",
  "University of Port Elizabeth",
  "University of Queensland",
  "University of Somalia",
  "University of the Western Cape",
  "Uppsala",
  "Utesa",
  "Utkal",
  "Utrecht",
  "Valencia",
  "Varna",
  "Vienna",
  "Visayas",
  "Volgograd",
  "Wales",
  "Washington",
  "West Indies",
  "Western Australia",
  "Western Ontario",
  "Wright State Univ - Ohio  USA",
  "Wurzburg",
  "Yangon",
  "Yaounde",
  "Yugoslawia Unv of Med Riseka",
  "Zagreb",
  "Zaire",
  "Zambia",
  "Zimbabwe",
  "Zugansu",
  " Zululand",
];

//
//  PatientAssessment.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-09-09.
//

import SwiftUI

struct PatientAssessment {
    var type: ScenarioType = .medical
    var scenarios: [Scenario] = [
        Scenario(
            type: .medical,
            sections: [
                ScenarioSection(
                    name: "Scene size up",
                    requirements: [
                        ScenarioRequirement(description: "Don BSI", importance: .critical),
                        ScenarioRequirement(description: "Hazard assessment (see/hear/smell)", importance: .critical),
                        ScenarioRequirement(description: "Noting time, date, weather", importance: .normal),
                        ScenarioRequirement(description: "How many pts?", importance: .normal),
                        ScenarioRequirement(description: "Request backup", importance: .normal, notes: "Always YES for scenarios"),
                        ScenarioRequirement(description: "Bystanders with information?", importance: .normal, notes: "Consider SAMPLE Hx"),
                        ScenarioRequirement(description: "C/C?", importance: .normal),
                        ScenarioRequirement(description: "Note Patient's general appearance", importance: .normal),
                        ScenarioRequirement(description: "MOI?", importance: .normal)
                    ]
                ),
                ScenarioSection(
                    name: "C-Spine",
                    requirements: [
                        ScenarioRequirement(description: "Have you fallen or hit your head recently?", importance: .normal, notes: "If needed, delegate holding C-Spine to partner"),
                    ]
                ),
                ScenarioSection(
                    name: "LOC",
                    requirements: [
                        ScenarioRequirement(description: "Conscious, PPTE", importance: .normal),
                        ScenarioRequirement(description: "Unconscious, AVPU", importance: .normal),
                    ]
                ),
                ScenarioSection(
                    name: "Airway",
                    requirements: [
                        ScenarioRequirement(description: "Patent & clear", importance: .critical),
                        ScenarioRequirement(description: "If not, I'm performing HTCL or JT", importance: .normal),
                        ScenarioRequirement(description: "Suction, if needed", importance: .normal),
                        ScenarioRequirement(description: "Odours?", importance: .normal),
                        ScenarioRequirement(description: "OPA/NPA?", importance: .normal)
                    ]
                ),
                ScenarioSection(
                    name: "Breathing",
                    requirements: [
                        ScenarioRequirement(description: "RRQ / RDE?", importance: .critical),
                        ScenarioRequirement(description: "Administer O2 (NRB 15 LPM)", importance: .critical),
                    ]
                ),
                ScenarioSection(
                    name: "Circulation",
                    requirements: [
                        ScenarioRequirement(description: "Carotid and radial pulse RRQ?", importance: .critical),
                        ScenarioRequirement(description: "Skin condition?", importance: .normal),
                    ]
                ),
                ScenarioSection(
                    name: "Deadly wet check",
                    requirements: [
                        ScenarioRequirement(description: "I'm checking for obvious, deadly bleeds", importance: .critical),
                    ]
                ),
                ScenarioSection(
                    name: "Transport",
                    requirements: [
                        ScenarioRequirement(description: "Load & Go / Stay & Stabilize", importance: .critical)
                    ]
                ),
                ScenarioSection(
                    name: "Physical exams",
                    decisionPointPhysicalOrReassessChoices: MedicalReassessmentType.allCases,
                    subSections: [
                        ScenarioSection(
                            decisionPointPhysicalOrReassess: .physical,
                            subSections: [
                                ScenarioSection(
                                    name: "Head",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .normal),
                                        ScenarioRequirement(description: "Facial droop?", importance: .normal),
                                        ScenarioRequirement(description: "Eyes PERL?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Neck",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .normal),
                                        ScenarioRequirement(description: "Accessory muscle use?", importance: .normal),
                                        ScenarioRequirement(description: "JVD?", importance: .normal),
                                        ScenarioRequirement(description: "Trachea midline?", importance: .normal),
                                        ScenarioRequirement(description: "Medic alert jewelry present?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Chest",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .normal),
                                        ScenarioRequirement(description: "Auscultate apics & bases for lung sounds", importance: .normal),
                                        ScenarioRequirement(description: "Percuss. Adventitious sounds?", importance: .normal),
                                        ScenarioRequirement(description: "SIMBA?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Abdomen",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .normal),
                                        ScenarioRequirement(description: "Feeling for DRT in all quadrants", importance: .normal),
                                        ScenarioRequirement(description: "Nauseaous/recently vomited?", importance: .normal),
                                        ScenarioRequirement(description: "Scars or needle marks?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Pelvis",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .normal),
                                        ScenarioRequirement(description: "Incontinence, bleeding, or discharge?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Lower extremities",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .normal),
                                        ScenarioRequirement(description: "Needle marks or medic alert jewelry?", importance: .normal),
                                        ScenarioRequirement(description: "Edema/discolouration?", importance: .normal),
                                        ScenarioRequirement(description: "CMS, test both simultaneously", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Upper extremities",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .normal),
                                        ScenarioRequirement(description: "Needle marks or medic alert jewelry?", importance: .normal),
                                        ScenarioRequirement(description: "Edema/discolouration?", importance: .normal),
                                        ScenarioRequirement(description: "CMS, test both simultaneously", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Back",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .normal),
                                        ScenarioRequirement(description: "Sacral edema/scars?", importance: .normal)
                                    ]
                                ),
                            ]
                        ),
                        ScenarioSection(
                            decisionPointPhysicalOrReassess: .reassess,
                            subSections: [
                                ScenarioSection(
                                    name: "Head",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain (OPQRST)", importance: .normal),
                                        ScenarioRequirement(description: "Facial droop?", importance: .normal),
                                        ScenarioRequirement(description: "Eyes PERL?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Neck",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain (OPQRST)", importance: .normal),
                                        ScenarioRequirement(description: "Accessory muscle use?", importance: .normal),
                                        ScenarioRequirement(description: "JVD?", importance: .normal),
                                        ScenarioRequirement(description: "Trachea midline?", importance: .normal),
                                        ScenarioRequirement(description: "Medic alert jewelry present?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Chest",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain (OPQRST)", importance: .normal),
                                        ScenarioRequirement(description: "Auscultate apics & bases for lung sounds", importance: .normal),
                                        ScenarioRequirement(description: "Percuss. Adventitious sounds?", importance: .normal),
                                        ScenarioRequirement(description: "SIMBA?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Abdomen",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain (OPQRST)", importance: .normal),
                                        ScenarioRequirement(description: "Feeling for DRT in all quadrants", importance: .normal),
                                        ScenarioRequirement(description: "Nauseaous/recently vomited?", importance: .normal),
                                        ScenarioRequirement(description: "Scars or needle marks?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Pelvis",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain (OPQRST)", importance: .normal),
                                        ScenarioRequirement(description: "Incontinence, bleeding, or discharge?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Lower extremities",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain (OPQRST)", importance: .normal),
                                        ScenarioRequirement(description: "Needle marks or medic alert jewelry?", importance: .normal),
                                        ScenarioRequirement(description: "Edema/discolouration?", importance: .normal),
                                        ScenarioRequirement(description: "CMS, test both simultaneously", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Upper extremities",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain (OPQRST)", importance: .normal),
                                        ScenarioRequirement(description: "Needle marks or medic alert jewelry?", importance: .normal),
                                        ScenarioRequirement(description: "Edema/discolouration?", importance: .normal),
                                        ScenarioRequirement(description: "CMS, test both simultaneously", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Back",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain (OPQRST)", importance: .normal),
                                        ScenarioRequirement(description: "Sacral edema/scars?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Critical interventions",
                                    requirements: [
                                        ScenarioRequirement(description: "Reassessing critical interventions", importance: .normal),
                                        ScenarioRequirement(description: "Address anything that needs to be done/changed", importance: .normal)
                                    ]
                                ),
                            ]
                        ),
                        ScenarioSection(
                            decisionPointPhysicalOrReassess: .transport,
                            subSections: [
                                ScenarioSection(
                                    name: "Reassess @ 5/15 mins",
                                    requirements: [
                                        ScenarioRequirement(description: "Reassess LOC", importance: .normal),
                                        ScenarioRequirement(description: "Reassess ABCs", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Vitals",
                                    requirements: [
                                        ScenarioRequirement(description: "BGL?", importance: .normal),
                                        ScenarioRequirement(description: "Sp02?", importance: .normal),
                                        ScenarioRequirement(description: "Pulse?", importance: .normal),
                                        ScenarioRequirement(description: "BP?", importance: .normal),
                                        ScenarioRequirement(description: "RR?", importance: .normal),
                                        ScenarioRequirement(description: "Temp?", importance: .normal),
                                        ScenarioRequirement(description: "Skin?", importance: .normal),
                                        ScenarioRequirement(description: "GCS?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "SAMPLE Hx"
                                ),
                                ScenarioSection(
                                    name: "Further interventions?"
                                ),
                            ]
                        )
                    ]
                ),
                ScenarioSection(
                    name: "What would I have done differently?"
                ),
                ScenarioSection(
                    name: "Complete"
                ),
            ]
        ),
        Scenario(
            type: .trauma,
            sections: [
                ScenarioSection(
                    name: "Scene size up",
                    requirements: [
                        ScenarioRequirement(description: "Don BSI", importance: .critical),
                        ScenarioRequirement(description: "Do I hear/see/small anything (hazard assessment)?", importance: .critical),
                        ScenarioRequirement(description: "How many pts?", importance: .normal),
                        ScenarioRequirement(description: "I am requesting backup from ALS and Fire", importance: .normal),
                        ScenarioRequirement(description: "MOI?", importance: .critical)
                    ]
                ),
                ScenarioSection(
                    name: "Initial assessment"
                ),
                ScenarioSection(
                    name: "Approach",
                    requirements: [
                        ScenarioRequirement(description: "Bystanders with information?", importance: .normal),
                        ScenarioRequirement(description: "General impression of pt?", importance: .normal),
                        ScenarioRequirement(description: "Obvious injuries/life threatening bleeding?", importance: .normal),
                    ]
                ),
                ScenarioSection(
                    name: "C-Spine",
                    requirements: [
                        ScenarioRequirement(description: "Take initial c-spine control", importance: .critical),
                        ScenarioRequirement(description: "Is c-spine stabilization required?", importance: .normal, notes: "If not, release c-spine"),
                    ]
                ),
                ScenarioSection(
                    name: "LOC",
                    requirements: [
                        ScenarioRequirement(description: "AVPU?", importance: .normal),
                        ScenarioRequirement(description: "C/C?", importance: .normal),
                        ScenarioRequirement(description: "Signs and symptoms?", importance: .normal),
                    ]
                ),
                ScenarioSection(
                    name: "Airway",
                    requirements: [
                        ScenarioRequirement(description: "Patent?", importance: .critical),
                        ScenarioRequirement(description: "Snoring/gurgling/stridor, or silence?", importance: .normal)
                    ]
                ),
                ScenarioSection(
                    name: "Breathing",
                    requirements: [
                        ScenarioRequirement(description: "Present?", importance: .critical),
                        ScenarioRequirement(description: "RDE?", importance: .normal),
                        ScenarioRequirement(description: "I am administering O2 via...", importance: .normal, notes: "15 LPM via NRB for scenarios")
                    ]
                ),
                ScenarioSection(
                    name: "Circulation",
                    requirements: [
                        ScenarioRequirement(description: "Present?", importance: .critical),
                        ScenarioRequirement(description: "RRQ @ radial & carotid?", importance: .normal),
                        ScenarioRequirement(description: "Skin colour, condition, temperature, cap refill?", importance: .normal),
                        ScenarioRequirement(description: "Has bleeding been controlled?", importance: .critical)
                    ]
                ),
                ScenarioSection(
                    name: "Assessment type",
                    requirements: [
                        ScenarioRequirement(description: "Is this a focused or rapid trauma assessment?", importance: .critical),
                    ]
                ),
                ScenarioSection(
                    name: "Interventions?"
                ),
                ScenarioSection(
                    name: "MOI indicates survey",
                    decisionPointRapidOrFocusedChoices: ITLSAssessmentType.allCases,
                    subSections: [
                        ScenarioSection(
                            decisionPointRapidOrFocused: .rapid,
                            subSections: [
                                ScenarioSection(
                                    name: "Head & Neck",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC (deformity, contustion, abrasion, penetration, burns, lacerations, swelling, tenderness, instability, crepitus)", importance: .critical),
                                        ScenarioRequirement(description: "JVD?", importance: .normal),
                                        ScenarioRequirement(description: "Trachea midline?", importance: .normal),
                                        ScenarioRequirement(description: "I am delegating or applying c-collar", importance: .critical)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Chest",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .critical),
                                        ScenarioRequirement(description: "Chest asymmetrical?", importance: .normal),
                                        ScenarioRequirement(description: "Paradoxical motion?", importance: .normal),
                                        ScenarioRequirement(description: "SQ emphysema?", importance: .normal),
                                        ScenarioRequirement(description: "I am auscultating for lung sounds & heart tones", importance: .normal, notes: "If decreased, percuss w/hand"),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Abdomen",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DRT", importance: .critical),
                                        ScenarioRequirement(description: "Evisceration, bruising, penetration?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Pelvis",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for TIC", importance: .critical),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Lower/upper extremities",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .critical),
                                        ScenarioRequirement(description: "CMS present x4?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Back",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .critical),
                                    ]
                                ),
                            ]
                        ),
                        ScenarioSection(
                            decisionPointRapidOrFocused: .focused,
                            subSections: [
                                ScenarioSection(
                                    name: "Area of injury",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .critical),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Vitals",
                                    requirements: [
                                        ScenarioRequirement(description: "Pulse?", importance: .normal),
                                        ScenarioRequirement(description: "BP?", importance: .normal),
                                        ScenarioRequirement(description: "RR?", importance: .normal),
                                        ScenarioRequirement(description: "GCS?", importance: .normal),
                                        ScenarioRequirement(description: "Pupils PERL?", importance: .normal)
                                    ]
                                ),
                            ]
                        ),
                    ]
                ),
                ScenarioSection(
                    name: "Critical situation?",
                    requirements: [
                        ScenarioRequirement(description: "Pt critical? ITLS Ongoing Exam. Stable? ITLS Secondary Survey", importance: .critical),
                    ],
                    decisionPointOngoingOrSecondaryChoices: ITLSSecondarySurveyType.allCases,
                    subSections: [
                        ScenarioSection(
                            decisionPointOngoingOrSecondary: .ongoing,
                            subSections: [
                                ScenarioSection(
                                    name: "Hx",
                                    requirements: [
                                        ScenarioRequirement(description: "SAMPLE?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "LOC",
                                    requirements: [
                                        ScenarioRequirement(description: "AVPU?", importance: .normal),
                                        ScenarioRequirement(description: "Pupils PERL?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Vitals",
                                    requirements: [
                                        ScenarioRequirement(description: "BGL?", importance: .normal),
                                        ScenarioRequirement(description: "Sp02?", importance: .normal),
                                        ScenarioRequirement(description: "Pulse?", importance: .normal),
                                        ScenarioRequirement(description: "BP?", importance: .normal),
                                        ScenarioRequirement(description: "RR?", importance: .normal),
                                        ScenarioRequirement(description: "Temp?", importance: .normal),
                                        ScenarioRequirement(description: "Skin?", importance: .normal),
                                        ScenarioRequirement(description: "GCS?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Airway",
                                    requirements: [
                                        ScenarioRequirement(description: "Patent?", importance: .normal),
                                        ScenarioRequirement(description: "Snoring, gurgling, stridor, or silence?", importance: .normal),
                                        ScenarioRequirement(description: "Signs of inhalation injury?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Breathing",
                                    requirements: [
                                        ScenarioRequirement(description: "Present?", importance: .normal),
                                        ScenarioRequirement(description: "RDE?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Circulation",
                                    requirements: [
                                        ScenarioRequirement(description: "RRQ @ radial & carotid?", importance: .normal),
                                        ScenarioRequirement(description: "Skin colour, condition, temperature, cap refill?", importance: .normal),
                                        ScenarioRequirement(description: "Is bleeding still controlled?", importance: .critical)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Neck",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .normal),
                                        ScenarioRequirement(description: "JVD?", importance: .normal),
                                        ScenarioRequirement(description: "Trachea midline?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Chest",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .normal),
                                        ScenarioRequirement(description: "Chest asymmetrical?", importance: .normal),
                                        ScenarioRequirement(description: "SQ emphysema?", importance: .normal),
                                        ScenarioRequirement(description: "Paradoxical motion?", importance: .normal),
                                        ScenarioRequirement(description: "I am auscultating for lung sounds/heart tones", importance: .normal)
                                    ]
                                ),
                                // @TODO: this is in the ITLS textbook but not the MFR manual, may re-add it later as it is official
//                                ScenarioSection(
//                                    name: "Breath sounds",
//                                    requirements: [
//                                        ScenarioRequirement(description: "Present? Unequal, percuss", importance: .critical),
//                                        ScenarioRequirement(description: "Heart tones?", importance: .normal),
//                                        ScenarioRequirement(description: "ACTION Auscultate for lung/heart sounds", importance: .normal),
//                                        ScenarioRequirement(description: "ACTION if decreased, percuss", importance: .normal)
//                                    ]
//                                ),
                                ScenarioSection(
                                    name: "Abdomen",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DRT", importance: .normal),
                                        ScenarioRequirement(description: "Evisceration, bruising, penetration, guarding?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Every 5 mins",
                                    requirements: [
                                        ScenarioRequirement(description: "Reassess LOC", importance: .normal),
                                        ScenarioRequirement(description: "Reassess ABCs", importance: .normal),
                                        ScenarioRequirement(description: "Reassess all interventions", importance: .normal),
                                        ScenarioRequirement(description: "Reassess vitals", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Handover to EMS",
                                    requirements: [
                                        ScenarioRequirement(description: "ICHAT", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "What's wrong with pt?",
                                    requirements: [
                                        ScenarioRequirement(description: "No extra marks", importance: .normal),
                                    ]
                                ),
                            ]
                        ),
                        ScenarioSection(
                            decisionPointOngoingOrSecondary: .secondary,
                            subSections: [
                                ScenarioSection(
                                    requirements: [
                                        ScenarioRequirement(description: "Reassess LOC", importance: .normal),
                                        ScenarioRequirement(description: "Reassess ABCs", importance: .normal),
                                    ]
                                ),
                                // @TODO: these are official ITLS steps missing from MFR guide, uncomment
//                                ScenarioSection(
//                                    name: "General impression of pt",
//                                    requirements: [
//                                        ScenarioRequirement(description: "Does pt appear better, worse, or unchanged?", importance: .normal),
//                                    ]
//                                ),
//                                ScenarioSection(
//                                    name: "LOC",
//                                    requirements: [
//                                        ScenarioRequirement(description: "AVPU?", importance: .normal),
//                                        ScenarioRequirement(description: "Pupils?", importance: .normal),
//                                    ]
//                                ),
//                                ScenarioSection(
//                                    name: "Airway w/C-Spine control",
//                                    requirements: [
//                                        ScenarioRequirement(description: "Patent?", importance: .normal),
//                                        ScenarioRequirement(description: "Snoring, gurgling, stridor, or silence?", importance: .normal),
//                                        ScenarioRequirement(description: "Signs of inhalation injury?", importance: .normal),
//                                    ]
//                                ),
//                                ScenarioSection(
//                                    name: "Breathing",
//                                    requirements: [
//                                        ScenarioRequirement(description: "Present?", importance: .normal),
//                                        ScenarioRequirement(description: "RDE?", importance: .normal),
//                                    ]
//                                ),
//                                ScenarioSection(
//                                    name: "Circulation",
//                                    requirements: [
//                                        ScenarioRequirement(description: "RRQ @ radial & carotid?", importance: .normal),
//                                        ScenarioRequirement(description: "Skin colour, condition, temperature, cap refill?", importance: .normal),
//                                        ScenarioRequirement(description: "Is bleeding still controlled?", importance: .normal)
//                                    ]
//                                ),
                                ScenarioSection(
                                    name: "Detailed exam"
                                ),
                                ScenarioSection(
                                    name: "Hx",
                                    requirements: [
                                        ScenarioRequirement(description: "SAMPLE?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Vitals",
                                    requirements: [
                                        ScenarioRequirement(description: "BGL?", importance: .normal),
                                        ScenarioRequirement(description: "Sp02?", importance: .normal),
                                        ScenarioRequirement(description: "Pulse?", importance: .normal),
                                        ScenarioRequirement(description: "BP?", importance: .normal),
                                        ScenarioRequirement(description: "RR?", importance: .normal),
                                        ScenarioRequirement(description: "Temp?", importance: .normal),
                                        ScenarioRequirement(description: "Skin?", importance: .normal),
                                        ScenarioRequirement(description: "GCS?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Interventions?"
                                ),
                                ScenarioSection(
                                    name: "Physical exam"
                                ),
                                ScenarioSection(
                                    name: "Head",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .normal),
                                        ScenarioRequirement(description: "Battle's sign/Raccoon eyes (late signs)?", importance: .normal),
                                        ScenarioRequirement(description: "Pupils PERL?", importance: .normal),
                                        ScenarioRequirement(description: "Discharge from ears/nose?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Neck",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .normal),
                                        ScenarioRequirement(description: "JVD?", importance: .normal),
                                        ScenarioRequirement(description: "Tracheal deviation?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Chest",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .normal),
                                        ScenarioRequirement(description: "Chest asymmetrical?", importance: .normal),
                                        ScenarioRequirement(description: "Paradoxical motion?", importance: .normal),
                                        ScenarioRequirement(description: "SQ emphysema?", importance: .normal),
                                        ScenarioRequirement(description: "Heart tones?", importance: .normal),
                                        ScenarioRequirement(description: "I am auscultating for lung sounds & heart tones", importance: .normal, notes: "If decreased, percuss w/hand"),
                                    ]
                                ),
                                // @TODO: this is in the ITLS textbook but not the MFR manual, may re-add it later as it is official
//                                ScenarioSection(
//                                    name: "Breath sounds",
//                                    requirements: [
//                                        ScenarioRequirement(description: "Present? Unequal, percuss", importance: .critical),
//                                        ScenarioRequirement(description: "Heart tones?", importance: .normal),
//                                        ScenarioRequirement(description: "ACTION Auscultate for lung/heart sounds", importance: .normal),
//                                        ScenarioRequirement(description: "ACTION if decreased, percuss", importance: .normal)
//                                    ]
//                                ),
                                ScenarioSection(
                                    name: "Abdomen",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DRT", importance: .normal),
                                        ScenarioRequirement(description: "Evisceration, bruising, penetration?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Pelvis",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Lower/upper extremities",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .normal),
                                        ScenarioRequirement(description: "Distal pulse, motor/sensory present?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Back",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking/feeling for DCAP-BLS TIC", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Every 15 mins",
                                    requirements: [
                                        ScenarioRequirement(description: "Reassess LOC", importance: .normal),
                                        ScenarioRequirement(description: "Reassess ABCs", importance: .normal),
                                        ScenarioRequirement(description: "Reassess all interventions", importance: .normal),
                                        ScenarioRequirement(description: "Reassess vitals", importance: .normal),
                                        ScenarioRequirement(description: "Recheck monitors", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Handover to EMS",
                                    requirements: [
                                        ScenarioRequirement(description: "ICHAT", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "What's wrong with pt?",
                                    requirements: [
                                        ScenarioRequirement(description: "No extra marks", importance: .normal),
                                    ]
                                ),
                            ]
                        )
                    ]
                ),
                ScenarioSection(
                    name: "What would I have done differently?"
                ),
                ScenarioSection(
                    name: "Complete"
                ),
            ]
        )
    ]
}

extension PatientAssessment {
    struct Views {
        struct Progress: View {
            typealias Coordinates = ScenarioCoordinates

            @State public var pa: PatientAssessment
            @Binding public var current: Coordinates

            var body: some View {
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Button {
                            self.actionOnNext()
                        } label: {
                            Text("Next")
                                .padding()
                        }
                        Spacer()
                    }
                }
            }
        }

        struct SectionList: View {
            typealias Coordinates = ScenarioCoordinates

            @State public var pa: PatientAssessment
            @Binding public var current: Coordinates
            @Binding public var type: ScenarioType
            @State public var selectedRequirements: Set<ScenarioRequirement> = []

            var body: some View {
                ScrollView(showsIndicators: false) {
                    ForEach(self.pa.scenarios, id: \.id) { scenario in
                        if scenario.type == self.type {
                            ForEach(scenario.sections, id: \.id) { section in
                                if !section.subSections.isEmpty {
                                    DecisionPoint(section: section, current: $current, type: $type, selectedRequirements: $selectedRequirements)
                                } else {
                                    SingleSection(section: section, current: $current, type: $type, selectedRequirements: $selectedRequirements, open: false)
                                }
                            }
                        }
                    }
                }
                .padding(8)
            }
        }

        struct DecisionPoint: View {
            typealias Coordinates = ScenarioCoordinates

            @Environment(\.colorScheme) var colourScheme
            @State public var section: ScenarioSection
            @Binding public var current: Coordinates
            @Binding public var type: ScenarioType
            @Binding public var selectedRequirements: Set<ScenarioRequirement>

            var body: some View {
                VStack(alignment: .leading, spacing: 0) {
                    if let name = section.name {
                        HStack(alignment: .center) {
                            Image(systemName: "stethoscope")
                                .foregroundStyle(.gray)
                            Text(name)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(.gray.opacity(0.6))
                    }

                    ForEach(section.requirements) { req in
                        SingleRequirement(requirement: req, current: $current, selectedRequirements: $selectedRequirements)
                    }

                    if section.decisionPointRapidOrFocusedChoices != nil {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(section.decisionPointRapidOrFocusedChoices!, id: \.self) { iType in
                                Button {
                                    current.decisionPointRapidOrFocused = iType
                                } label: {
                                    HStack(alignment: .center, spacing: 0) {
                                        HStack {
                                            Spacer()
                                            Text(iType.label)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .background(iType == current.decisionPointRapidOrFocused ? type.colour : .gray.opacity(0.3))
                                }
                            }
                        }
                        .background(.gray)
                        .border(width: 5, edges: [.bottom], color: type.colour)

                        if current.decisionPointRapidOrFocused != nil {
                            ForEach(section.subSections, id: \.id) { subSection in
                                if current.decisionPointRapidOrFocused == subSection.decisionPointRapidOrFocused {
                                    SingleSection(
                                        section: subSection,
                                        current: $current,
                                        type: $type,
                                        selectedRequirements: $selectedRequirements,
                                        open: current.decisionPointRapidOrFocused == subSection.decisionPointRapidOrFocused
                                    )
                                }
                            }
                        }

                    } else if section.decisionPointOngoingOrSecondaryChoices != nil {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(section.decisionPointOngoingOrSecondaryChoices!, id: \.self) { iType in
                                Button {
                                    current.decisionPointOngoingOrSecondary = iType
                                } label: {
                                    HStack(alignment: .center, spacing: 0) {
                                        HStack {
                                            Spacer()
                                            Text(iType.label)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .background(iType == current.decisionPointOngoingOrSecondary ? type.colour : .gray.opacity(0.3))
                                }
                            }
                        }
                        .background(.gray)
                        .border(width: 5, edges: [.bottom], color: type.colour)

                        if current.decisionPointOngoingOrSecondary != nil {
                            ForEach(section.subSections, id: \.id) { subSection in
                                if current.decisionPointOngoingOrSecondary == subSection.decisionPointOngoingOrSecondary {
                                    SingleSection(
                                        section: subSection,
                                        current: $current,
                                        type: $type,
                                        selectedRequirements: $selectedRequirements,
                                        open: current.decisionPointOngoingOrSecondary == subSection.decisionPointOngoingOrSecondary
                                    )
                                }
                            }
                        }
                    } else if section.decisionPointPhysicalOrReassessChoices != nil {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(section.decisionPointPhysicalOrReassessChoices!, id: \.self) { iType in
                                Button {
                                    current.decisionPointPhysicalOrReassess = iType
                                } label: {
                                    HStack(alignment: .center, spacing: 0) {
                                        HStack {
                                            Spacer()
                                            Text(iType.icon).font(.title2)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .background(iType == current.decisionPointPhysicalOrReassess ? type.colour : .gray.opacity(0.3))
                                }
                            }
                        }
                        .background(.gray)
                        .border(width: 5, edges: [.bottom], color: type.colour)

                        if current.decisionPointPhysicalOrReassess != nil {
                            ForEach(section.subSections, id: \.id) { subSection in
                                if current.decisionPointPhysicalOrReassess == subSection.decisionPointPhysicalOrReassess {
                                    SingleSection(
                                        section: subSection,
                                        current: $current,
                                        type: $type,
                                        selectedRequirements: $selectedRequirements,
                                        open: current.decisionPointPhysicalOrReassess == subSection.decisionPointPhysicalOrReassess
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }

        struct SingleRequirement: View {
            typealias Coordinates = ScenarioCoordinates

            @Environment(\.colorScheme) var colourScheme
            @State public var requirement: ScenarioRequirement
            @Binding public var current: Coordinates
            @Binding public var selectedRequirements: Set<ScenarioRequirement>
            @State private var completed: Bool = false

            var body: some View {
                VStack(alignment: .leading, spacing: 0) {
                    Button {
                        self.completed.toggle()
                        self.requirement.completed.toggle()

                        if self.selectedRequirements.contains(self.requirement) {
                            self.selectedRequirements.remove(self.requirement)
                        } else {
                            self.selectedRequirements.insert(self.requirement)
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .center, spacing: 0) {
                                Text(requirement.description)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            HStack(alignment: .center, spacing: 0) {
                                Image(systemName: self.completed ? "checkmark.square.fill" : "checkmark.square")
                                    .font(.title2)
                                    .opacity(0.4)
                            }

                        }
                        .padding(8)
                        .foregroundStyle(self.completed ? .gray : colourScheme == .dark ? .white : .black)
                        .background(self.completed ? .green : self.requirement.importance == .critical ? .yellow : .gray.opacity(0.4))
                    }

                    if self.requirement.notes != nil && !self.completed {
                        HStack(alignment: .center, spacing: 8) {
                            Image(systemName: "note.text")
                            Text(self.requirement.notes!)
                            Spacer()
                        }
                        .padding(8)
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .background(current.requirement == self.requirement.id ? .blue : self.requirement.importance == .critical ? .yellow : .gray.opacity(0.3))
                    }
                }
                .opacity(self.completed ? 0.5 : 1)
            }
        }

        struct SingleSection: View {
            typealias Coordinates = ScenarioCoordinates

            @Environment(\.colorScheme) var colourScheme
            public var section: ScenarioSection
            @Binding public var current: Coordinates
            @Binding public var type: ScenarioType
            @Binding public var selectedRequirements: Set<ScenarioRequirement>
            @State public var open: Bool
            @State private var completed: Bool = false
            @State private var totalRequirementCount: Int = 0
            @State private var selectedRequirementCount: Int = 0

            var body: some View {
                VStack(alignment: .leading, spacing: 1) {
                    if let name = section.name {
                        Button {
                            self.completed.toggle()

                            // @TODO: check all sub-items
                        } label: {
                            HStack(alignment: .center, spacing: 0) {
                                HStack(alignment: .center, spacing: 0) {
                                    Text(name)
                                        .multilineTextAlignment(.leading)
                                            .bold()
                                    Spacer()
                                    Text("\(self.selectedRequirementCount)/\(self.totalRequirementCount)")
                                }
                                Spacer()
                                HStack(alignment: .center, spacing: 0) {
                                    Image(systemName: self.completed ? "checkmark.square.fill" : "checkmark.square")
                                        .opacity(0.4)
                                }
                            }
                            .font(.title2)
                            .padding(8)
                            .foregroundStyle(self.completed ? .gray : colourScheme == .dark ? .white : .black)
                            //                        .foregroundStyle(current.section == section.id ? .white : .gray)
                            .background(self.completed ? .green : current.section == section.id ? .blue : .gray.opacity(0.6))
                        }
                        .opacity(self.completed ? 0.5 : 1)
                    }

                    if !self.completed {
                        ForEach(section.requirements) { req in
                            SingleRequirement(requirement: req, current: $current, selectedRequirements: $selectedRequirements)
                        }

                        ForEach(section.subSections, id: \.id) { subSection in
                            HStack(alignment: .center, spacing: 1) {
                                Rectangle()
                                    .foregroundStyle(type.colour)
                                    .frame(width: 5)
                                SingleSection(
                                    section: subSection,
                                    current: $current,
                                    type: $type,
                                    selectedRequirements: $selectedRequirements,
                                    open: open
                                )
                            }
                            .opacity(self.completed ? 0.5 : 1)
                        }
                    }
                }
                .onAppear(perform: self.actionOnAppear)
                .onChange(of: self.selectedRequirements) {
                    self.actionOnAppear()
                }
            }
        }
    }
}

extension PatientAssessment.Views.SingleSection {
    /// Onload handler
    /// - Returns: Void
    private func actionOnAppear() -> Void {
        self.selectedRequirementCount = self.section.requirements.count(where: {$0.completed == true})
        self.totalRequirementCount = self.section.requirements.count
    }
}

extension PatientAssessment.Views.Progress {
    private func actionOnNext() -> Void {
//        if let typeIndex = self.pa.sections.firstIndex(where: {$0.id == current.section}) {
//        if let currentIndex = self.pa.sections.firstIndex(where: {$0.id == current.section}) {
//            let nextIndex = self.pa.sections.index(after: currentIndex)
//            if let nextSection = self.pa.sections.enumerated().filter({$0.offset == nextIndex}).first {
//                if let currentSection = self.pa.sections.enumerated().filter({$0.offset == currentIndex}).first {
//                    let lastRequirementInSection = currentSection.element.requirements.last
//                    let currentRequirementIndex = currentSection.element.requirements.firstIndex(where: {$0.id == current.requirement}) ?? 0
//                    let currentRequirement = currentSection.element.requirements.enumerated().filter({$0.offset == currentRequirementIndex}).first
//                    let nextRequirementIndex = currentSection.element.requirements.index(after: currentRequirementIndex)
//                    let nextRequirement = currentSection.element.requirements.enumerated().filter({$0.offset == nextRequirementIndex}).first
//                    let nextSectionFirstRequirement = nextSection.element.requirements.first
//
//                    if let nReq = nextRequirement?.element {
//                        if nReq.id == lastRequirementInSection?.id {
//                            current.section = nextSection.element.id
//                            current.requirement = nextSectionFirstRequirement?.id
//                            print("DERPO changed sections to \(current.section!)")
//                            print("DERPO changed requirement to \(current.requirement!)")
//                        } else {
//                            current.requirement = nextRequirement?.element.id
//                            print("DERPO changed requirement to \(current.requirement!)")
//                        }
//                    }
//                }
//            }
//        }
    }
}

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
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .critical),
                                        ScenarioRequirement(description: "Facial droop?", importance: .normal),
                                        ScenarioRequirement(description: "Eyes PERL?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Neck",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .critical),
                                        ScenarioRequirement(description: "Accessory muscle use?", importance: .normal),
                                        ScenarioRequirement(description: "JVD?", importance: .normal),
                                        ScenarioRequirement(description: "Trachea midline?", importance: .normal),
                                        ScenarioRequirement(description: "Medic alert jewelry present?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Chest",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .critical),
                                        ScenarioRequirement(description: "Auscultate apics & bases for lung sounds", importance: .critical),
                                        ScenarioRequirement(description: "If sounds decreased, percuss. Adventitious sounds?", importance: .normal),
                                        ScenarioRequirement(description: "SIMBA?", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Abdomen",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .critical),
                                        ScenarioRequirement(description: "Feeling for DRT in all quadrants", importance: .normal),
                                        ScenarioRequirement(description: "Nauseaous/recently vomited?", importance: .normal),
                                        ScenarioRequirement(description: "Scars or needle marks?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Pelvis",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .critical),
                                        ScenarioRequirement(description: "Incontinence, bleeding, or discharge?", importance: .normal),
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Lower extremities",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .critical),
                                        ScenarioRequirement(description: "Needle marks or medic alert jewelry?", importance: .normal),
                                        ScenarioRequirement(description: "Edema/discolouration?", importance: .normal),
                                        ScenarioRequirement(description: "CMS, test both simultaneously", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Upper extremities",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .critical),
                                        ScenarioRequirement(description: "Needle marks or medic alert jewelry?", importance: .normal),
                                        ScenarioRequirement(description: "Edema/discolouration?", importance: .normal),
                                        ScenarioRequirement(description: "CMS, test both simultaneously", importance: .normal)
                                    ]
                                ),
                                ScenarioSection(
                                    name: "Back",
                                    requirements: [
                                        ScenarioRequirement(description: "Looking & feeling for injuries or pain", importance: .critical),
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

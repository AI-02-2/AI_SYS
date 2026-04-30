import Foundation

enum LLMPromptTemplate {
    static func summarize(caseNumber: String, caseName: String, issue: String, holding: String, examPoints: String) -> String {
        """
        [ROLE]
        You are a legal study assistant for Korean police exam preparation.

        [TASK]
        Summarize the precedent in plain Korean with exam focus.

        [RULES]
        1. Use only provided evidence fields.
        2. If evidence is insufficient, explicitly state uncertainty.
        3. Do not invent statute numbers, dates, or holdings.
        4. Output format must follow exactly.

        [EVIDENCE]
        case_number: \(caseNumber)
        case_name: \(caseName)
        issue_summary: \(issue)
        holding_summary: \(holding)
        exam_points: \(examPoints)

        [OUTPUT]
        - one_line_summary:
        - key_issue:
        - ruling_point:
        - exam_takeaway:
        """
    }

    static func compare(question: String, evidenceBlock: String) -> String {
        """
        [ROLE]
        You compare precedents based only on evidence.

        [TASK]
        Compare legal differences relevant to the user question.

        [QUESTION]
        \(question)

        [EVIDENCE]
        \(evidenceBlock)

        [RULES]
        1. Mention case_number for every claim.
        2. If conflict exists, describe both positions separately.
        3. If evidence does not support claim, say 'not supported by evidence'.

        [OUTPUT]
        - common_points:
        - differences:
        - likely_exam_trap:
        - citations: [case_number list]
        """
    }

    static func quiz(question: String, evidenceBlock: String) -> String {
        """
        [ROLE]
        You generate one multiple-choice quiz from evidence only.

        [TASK]
        Create one 4-choice item with one correct answer and explanation.

        [QUESTION]
        \(question)

        [EVIDENCE]
        \(evidenceBlock)

        [RULES]
        1. Avoid ambiguous options.
        2. Correct answer must be directly supported by evidence.
        3. Include citation in explanation.

        [OUTPUT]
        - prompt:
        - options:
          1)
          2)
          3)
          4)
        - correct_index: (0-3)
        - explanation:
        - citations: [case_number list]
        """
    }

    /// OX 퀴즈 생성 프롬프트
    /// 출력 형식: 문항마다 "---" 구분자 사용
    static func oxQuiz(caseNumber: String, caseName: String, keySentences: String, keywords: String, count: Int) -> String {
        """
        [ROLE]
        You are a Korean police exam preparation assistant generating O/X quiz items.

        [TASK]
        Generate exactly \(count) O/X quiz statements based ONLY on the evidence below.
        Each statement is either correct (O) or incorrect (X) about the precedent.

        [EVIDENCE]
        case_number: \(caseNumber)
        case_name: \(caseName)
        keywords: \(keywords)
        key_sentences:
        \(keySentences)

        [RULES]
        1. Each statement must be checkable as true or false from the evidence.
        2. Mix O and X answers (do not make all O or all X).
        3. Keep each statement under 80 Korean characters.
        4. Explanation must cite the case_number.
        5. Separate each item with exactly "---".

        [OUTPUT FORMAT — repeat \(count) times separated by ---]
        - statement: (Korean statement about the precedent)
        - answer: O or X
        - explanation: (Korean explanation citing \(caseNumber))
        ---
        """
    }
}

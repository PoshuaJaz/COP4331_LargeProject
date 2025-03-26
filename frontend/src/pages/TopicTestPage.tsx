// this page shows questions related to the chosen topic
import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import Layout from "../components/Layout";
import axios from "axios";

const TopicTestPage: React.FC = () => {
  const { topicName } = useParams<{ topicName: string }>();
  const [problems, setProblems] = useState<any[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [selectedAnswer, setSelectedAnswer] = useState<string | null>(null);
  const [answered, setAnswered] = useState(false);
  const [correctCount, setCorrectCount] = useState(0);
  const [showResult, setShowResult] = useState(false);
  const navigate = useNavigate();

  // get question from DB
  useEffect(() => {
    const fetchProblems = async () => {
      try {
        const res = await axios.get(`/api/test/topic/${topicName}`);
        const data = res.data;

        // shuffle problems
        const shuffledProblems = data.sort(() => 0.5 - Math.random());

        // shuffle choices
        const withOptions = shuffledProblems.map((p: any) => ({
          ...p,
          options: [p.answerCorrect, ...p.answersWrong].sort(
            () => 0.5 - Math.random()
          ),
        }));

        setProblems(withOptions);
      } catch (err) {
        console.error("Failed to load topic problems", err);
      }
    };

    if (topicName) fetchProblems();
  }, [topicName]);

  // summit answer and send to server
  const handleSubmit = async () => {
    if (!selectedAnswer) return;
    const current = problems[currentIndex];
    const isCorrect = selectedAnswer === current.answerCorrect;

    if (isCorrect) setCorrectCount((prev) => prev + 1);
    setAnswered(true);

    try {
      const token = localStorage.getItem("token");

      await axios.post(
        "/api/test/submit",
        {
          problem_id: current._id,
          isCorrect,
          category: current.category,
          topic: current.subcategory,
        },
        {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        }
      );
    } catch (err) {
      console.error("Failed to submit answer", err);
    }
  };

  const handleNext = () => {
    setSelectedAnswer(null);
    setAnswered(false);
    if (currentIndex + 1 < problems.length) {
      setCurrentIndex((prev) => prev + 1);
    } else {
      setShowResult(true);
    }
  };

  if (!problems.length) {
    return (
      <Layout>
        <div className="text-center text-xl sm:text-2xl mt-20 font-semibold text-gray-700">
          Problem not found
        </div>
      </Layout>
    );
  }

  if (showResult) {
    const percentage = (correctCount / problems.length) * 100;
    return (
      <Layout>
        <div className="flex flex-col justify-center items-center min-h-screen px-4 sm:px-8 py-8 text-center">
          <h1 className="text-3xl sm:text-4xl md:text-5xl font-black mb-4 sm:mb-6">
            Quiz Completed!
          </h1>
          <p className="text-lg sm:text-xl md:text-2xl mb-4 sm:mb-6">
            You got {correctCount} out of {problems.length} questions correct!
          </p>
          <p className="text-lg sm:text-xl md:text-2xl mb-4 sm:mb-6 font-bold">
            {percentage < 50 ? "Keep practicing!" : "Great job!"}
          </p>
          <div className="flex flex-col sm:flex-row justify-center gap-4">
            <button
              onClick={() => navigate("/topic-practice")}
              className="bg-yellow-400 hover:bg-yellow-500 text-black px-6 py-3 text-sm sm:text-base font-semibold rounded-full shadow"
            >
              Go to different topic
            </button>
            <button
              onClick={() => navigate("/mock-test")}
              className="bg-yellow-400 hover:bg-yellow-500 text-black px-6 py-3 text-sm sm:text-base font-semibold rounded-full shadow"
            >
              Go to mock test
            </button>
          </div>
        </div>
      </Layout>
    );
  }

  const current = problems[currentIndex];

  return (
    <Layout>
      <div className="max-w-5xl mx-auto px-4 sm:px-6 md:px-8 py-8 sm:py-12 mt-10 sm:mt-16">
        {/* Header: subcategory + date + number */}
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
          <h1 className="text-xl sm:text-3xl md:text-5xl font-bold text-gray-900">
            {current.subcategory}
            <span className="block text-sm sm:text-xl md:text-2xl text-gray-500 font-normal">
              (Exam Date: {current.exam_id})
            </span>
          </h1>
          <p className="text-sm sm:text-lg md:text-xl font-medium">
            Question {currentIndex + 1} of {problems.length}
          </p>
        </div>

        {/* Question */}
        <div className="mb-4">
          <h2 className="text-base sm:text-xl md:text-2xl font-bold mb-2">
            Q{currentIndex + 1}. {current.question}
          </h2>
        </div>

        {/* Options */}
        <div className="space-y-3">
          {current.options.map((ans: string, idx: number) => (
            <label
              key={idx}
              className={`block p-3 sm:p-4 rounded-lg border transition cursor-pointer text-sm sm:text-lg md:text-xl ${
                selectedAnswer === ans
                  ? "bg-yellow-100 border-yellow-500"
                  : "bg-white border-gray-300 hover:bg-gray-50"
              }`}
            >
              <input
                type="radio"
                name="answer"
                value={ans}
                checked={selectedAnswer === ans}
                onChange={() => setSelectedAnswer(ans)}
                className="mr-3"
              />
              {ans}
            </label>
          ))}
        </div>

        {/* Buttons */}
        <div className="mt-6 flex space-x-4">
          {!answered ? (
            <button
              onClick={handleSubmit}
              className="bg-yellow-600 hover:bg-yellow-700 text-white px-6 py-3 rounded shadow text-sm sm:text-base md:text-lg"
            >
              Submit
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="bg-yellow-400 hover:bg-yellow-500 text-black px-6 py-3 rounded shadow text-sm sm:text-base md:text-lg"
            >
              {currentIndex + 1 === problems.length ? "Result" : "Next"}
            </button>
          )}
        </div>

        {/* Feedback */}
        {answered && (
          <div className="mt-6 p-4 bg-gray-100 text-center rounded text-sm sm:text-base md:text-lg font-medium">
            {selectedAnswer === current.answerCorrect ? (
              <p className="text-black">Correct answer!</p>
            ) : (
              <p className="text-red-600">
                Incorrect. Correct answer:{" "}
                <strong>{current.answerCorrect}</strong>
              </p>
            )}
          </div>
        )}
      </div>
    </Layout>
  );
};

export default TopicTestPage;

document.querySelectorAll('[data-quiz]').forEach((quiz) => {
  const feedback = quiz.querySelector('.feedback');

  quiz.querySelectorAll('button').forEach((button) => {
    button.addEventListener('click', () => {
      const correct = button.dataset.correct === 'true';
      feedback.textContent = correct
        ? quiz.dataset.feedbackCorrect || 'Richtig.'
        : quiz.dataset.feedbackWrong || 'Noch nicht. Versuche es erneut.';
      feedback.className = `feedback ${correct ? 'correct' : 'wrong'}`;
    });
  });
});

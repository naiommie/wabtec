<div class="mx-8 rounded-lg bg-[rgba(0,0,0,0.2)] p-10 mt-10 text-gray-100">
    <div class="flex justify-between items-start mb-4">
        <a href="/project2" class="underline hover:bg-[rgba(0,0,0,0.2)]">Back to decision matrix table...</a>
      </div>
    <h2 class="text-2xl font-bold mb-4">Accuracy</h2>
      <p class="mb-4">To score the accuracy of QVscribe and SES RAT based on the given differences in their evaluation results, we will analyze the consistency and divergence in their scoring. The more similar their results are, the higher the confidence in their accuracy. However, without the ground truth it can be hard to find the accuracy.</p>
      <h3 class="text-xl font-bold mb-2">Exact Matches:</h3>
      <ul class="list-disc pl-6 mb-4">
        <li>875 requirements scored the same by both tools (0, 50, or 100).</li>
    </ul>
    <h3 class="text-xl font-bold mb-2">Positive Differences (QVscribe Scores Higher):</h3>
    <ul class="list-disc pl-6 mb-4">
      <li>+25 Difference (29 requirements): Similar to the +50 difference, but less frequent. It still shows that QVscribe is scoring slightly higher.</li>
      <li>+50 Difference (340 requirements): A considerable number of requirements are scored 50 points higher by QVscribe. This could indicate that QVscribe tends to rate these requirements more positively or leniently compared to SES.</li>
      <li>+75 Difference (10 requirements): Another indicator that QVscribe is more generous or SES is stricter in these cases.</li>
      <li>+100 Difference (17 requirements): This indicates a substantial number of requirements where QVscribe scores significantly higher than SES, suggesting a major divergence in scoring criteria.</li>
    </ul>
    <h3 class="text-xl font-bold mb-2">Negative Differences (QVscribe Scores Lower):</h3>
    <ul class="list-disc pl-6 mb-4">
      <li>-25 Difference (3 requirements): Minor but notable differences where QVscribe scores are lower than SES.</li>
      <li>-50 Difference (66 requirements): Indicates instances where QVscribe scores are lower than SES by 50 points. This suggests that SES might find more clarity or quality in these requirements compared to QVscribe.</li>
      <li>-75 Difference (5 requirements): Less frequent but notable differences where QVscribe scores are substantially lower.</li>
      <li>-100 Difference (22 requirements): Significant difference where QVscribe scores much lower, indicating that QVscribe finds these requirements lacking in clarity or quality.</li>
    </ul>
      <h3 class="text-xl font-bold mb-6">Scoring Accuracy Based on Consistency</h3>
      <div class="overflow-x-auto">
        <table class="w-full border-2">
          <thead>
            <tr class="bg-[rgba(0,0,0,0.4)] border-b-2">
              <th class="border-2 p-2">Criteria</th>
              <th class="border-2 p-2">QVscribe</th>
              <th class="border-2 p-2">SES RAT</th>
              <th class="border-2 p-2">Difference</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="border-2 p-2">Small Differences (±25)</td>
              <td class="border-2 p-2">(29/1367) * 100 = 1.7%</td>
              <td class="border-2 p-2">(3/1367) * 100 = 0.2%</td>
              <td class="border-2 p-2">1.5%</td>
            </tr>
            <tr>
              <td class="border-2 p-2">Moderate Differences (±50)</td>
              <td class="border-2 p-2">(340/1367) * 100 = 24.9%</td>
              <td class="border-2 p-2">(66/1367) * 100 = 4.8%</td>
              <td class="border-2 p-2">20.1%</td>
            </tr>
            <tr>
              <td class="border-2 p-2">Large Differences (±75)</td>
              <td class="border-2 p-2">(10/1367) * 100 = 0.7%</td>
              <td class="border-2 p-2">(5/1367) * 100 = 0.4%</td>
              <td class="border-2 p-2">0.3%</td>
            </tr>
            <tr>
              <td class="border-2 p-2">Extreme Differences (±100)</td>
              <td class="border-2 p-2">(22/1367) * 100 = 1.6%</td>
              <td class="border-2 p-2">(17/1367) * 100 = 1.2%</td>
              <td class="border-2 p-2">0.4%</td>
            </tr>
            <tr>
              <td class="border-2 p-2 font-bold">Total</td>
              <td class="border-2 p-2 font-bold">28.9%</td>
              <td class="border-2 p-2 font-bold">6.6%</td>
              <td class="border-2 p-2 font-bold">22.3%</td>
            </tr>
          </tbody>
        </table>
      </div>
      <h3 class="text-xl font-bold mt-4 mb-4">Final Accuracy Scores</h3>
      <p class="mb-4">QVScribe and SES RAT: Given the combined analysis, both tools exhibit an overall similar accuracy score. However, QVscribe tends to score higher on 396 requirements. This could suggest that QVscribe has a more optimistic scoring. Turning to SES RAT, it scores higher only on 96 requirements, indicating more strict rules, therefore more clarity or quality in these requirements.</p>
      <ul class="list-disc pl-6 mb-4">
        <li>QVscribe: 70%</li>
        <li>SES RAT: 90%</li>
      </ul>
      <p class="mb-4">These scores reflect the accuracy of both tools in identifying issues in requirements, acknowledging that there are some discrepancies but overall a high level of agreement in their evaluations. In addition, without a ground truth, it's difficult to assert which tool is more accurate.</p>
  
  </div>
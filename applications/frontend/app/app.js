const API_BASE = '/api';
const leaderboardBody = document.getElementById('leaderboardBody');
const errorMessage = document.getElementById('errorMessage');
const lastRefreshed = document.getElementById('lastRefreshed');

const formatPercent = (value) => {
  const numeric = Number(value);
  if (Number.isNaN(numeric)) {
    return '—';
  }
  return `${numeric.toFixed(1)}%`;
};

const formatMinutes = (value) => {
  const numeric = Number(value);
  if (Number.isNaN(numeric)) {
    return '—';
  }
  return `${numeric.toFixed(1)}`;
};

const formatNumber = (value) => {
  if (value === null || value === undefined) {
    return '—';
  }
  const numeric = Number(value);
  if (Number.isNaN(numeric)) {
    return `${value}`;
  }
  return numeric.toLocaleString();
};

const formatDateTime = (value) => {
  if (!value) {
    return '—';
  }
  const normalized = value.endsWith('Z') ? value : `${value}Z`;
  const date = new Date(normalized);
  if (Number.isNaN(date.getTime())) {
    return value;
  }
  return date.toLocaleString(undefined, {
    month: 'short',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
  });
};

const showError = (message) => {
  errorMessage.textContent = message;
  errorMessage.style.display = 'block';
};

const clearError = () => {
  errorMessage.textContent = '';
  errorMessage.style.display = 'none';
};

const renderLeaderboard = (rows) => {
  leaderboardBody.innerHTML = '';

  if (!rows.length) {
    const emptyRow = document.createElement('tr');
    const cell = document.createElement('td');
    cell.colSpan = 9;
    cell.textContent = 'No leaderboard data available yet.';
    emptyRow.appendChild(cell);
    leaderboardBody.appendChild(emptyRow);
    return;
  }

  rows.forEach((row, index) => {
    const tr = document.createElement('tr');
    const cells = [
      index + 1,
      row.gamer_tag,
      row.region,
      formatNumber(row.player_level),
      formatNumber(row.total_matches),
      formatPercent(row.win_rate),
      formatMinutes(row.avg_session_length),
      row.favorite_mode,
      formatDateTime(row.last_login),
    ];

    cells.forEach((value, cellIndex) => {
      const td = document.createElement('td');
      td.textContent = value;
      if (cellIndex === 5 || cellIndex === 6) {
        td.classList.add('metric');
      }
      tr.appendChild(td);
    });

    leaderboardBody.appendChild(tr);
  });
};

const fetchLeaderboard = async () => {
  leaderboardBody.innerHTML = '<tr><td colspan="9">Loading leaderboard...</td></tr>';
  clearError();

  try {
    const response = await fetch(`${API_BASE}/leaderboard`);
    if (!response.ok) {
      throw new Error(`Request failed with status ${response.status}`);
    }
    const data = await response.json();
    renderLeaderboard(data);
    lastRefreshed.textContent = `Last refreshed: ${new Date().toLocaleString()}`;
  } catch (error) {
    console.error('Failed to load leaderboard:', error);
    showError('Unable to load leaderboard data. Please try again later.');
    leaderboardBody.innerHTML = '<tr><td colspan="9">Leaderboard unavailable.</td></tr>';
    lastRefreshed.textContent = '';
  }
};

document.addEventListener('DOMContentLoaded', fetchLeaderboard);

class AuthenticationError extends Error {
  constructor(message) {
    super(message);
    this.name = 'AuthenticationError';
  }
}

class TimeoutError extends Error {
  constructor(message) {
    super(message);
    this.name = 'TimeoutError';
  }
}

class PayloadLimitError extends Error {
  constructor(message) {
    super(message);
    this.name = 'PayloadLimitError';
  }
}

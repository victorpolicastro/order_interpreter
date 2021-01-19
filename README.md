# README

Order Interpreter is an API to create orders

# How to run?
1. Clone the git repository
  `git clone git@github.com:victorpolicastro/order_interpreter.git`
2. Run bundle to install project's dependencies
  `bundle`
3. Run the following command to setup database
  `rails db:setup`
4. Start the server
  `bin/rails s`

# Linter
To see linter offenses, run:
  `rubocop`

# Tests
To run all project tests, run:
  `rspec`

# Next steps
Due to time, the following list can't be done
1. 100% of spec coverage
2. Test the request for API and SendRequestService with WebMock
3. Fix failling spec and service
4. Create a Worker to send request

# Snuffle

Snuffle analyzes source code to identify "data clumps", clusters of attributes
that are often used together. It uses this analysis to propose objects that
may be extracted from a given class.

## Installation

Add this line to your application's Gemfile:

    gem 'snuffle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install snuffle

## Usage

    > sp = Snuffle::SourceParser.new("./spec/fixtures/program_2.rb")
    > sp.report
     => [
          {
            :source_file=>"./spec/fixtures/program_2.rb",
            :object_candidates=> [
              [:city, :postal_code, :state],
              [:city, :state],
              [:company_name, :customer_name]
            ]
          }
        ]

## Contributing

Please note that this project is released with a [Contributor Code of Conduct](https://gitlab.com/coraline/snuffle/blob/master/CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.

1. Fork the project
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Merge Request

require 'spec_helper'

describe "Indenting" do
  specify "lists" do
    <<-EOF
      def example do
        [ :foo,
          :bar,
          :baz ]
      end
    EOF
    .should be_elixir_indentation
  end

  specify "keyword list" do
    <<-EOF
      def project do
        [ name: "mix",
          version: "0.1.0",
          deps: deps ]
      end
    EOF
    .should be_elixir_indentation
  end

  specify "keyword" do
    <<-EOF
      def config do
        [ name:
          "John" ]
      end
    EOF
    .should be_elixir_indentation
  end

  specify "list of tuples" do
    <<-EOF
    def test do
      [ { :cowboy, github: "extend/cowboy" },
        { :dynamo, "0.1.0-dev", github: "elixir-lang/dynamo" },
        { :ecto, github: "elixir-lang/ecto" },
        { :pgsql, github: "semiocast/pgsql" } ]
    end
    EOF
    .should be_elixir_indentation
  end

  specify "list of lists" do
    <<-EOF
    def test do
      [ [:a, :b, :c],
        [:d, :e, :f] ]
    end
    EOF
    .should be_elixir_indentation
  end

  specify "complex list" do
    <<-EOF
    def test do
      [ app: :first,
        version: "0.0.1",
        dynamos: [First.Dynamo],
        compilers: [:elixir, :dynamo, :ecto, :app],
        env: [prod: [compile_path: "ebin"]],
        compile_path: "tmp/first/ebin",
        deps: deps ]
    end
    EOF
    .should be_elixir_indentation
  end

  specify "lists with break line after square brackets" do
    <<-EOF
    def project do
      deps: [
        { :bar, path: "deps/umbrella/apps/bar" },
        { :umbrella, path: "deps/umbrella" }
      ]
    end
    EOF
    .should be_elixir_indentation
  end
end

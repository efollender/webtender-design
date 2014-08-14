require 'pg'
 
module Bartender
  class DBI
 
    # this initialize method is only ever run once. make sure you
    # update your `dbname`. here it is petbreeder.
    def initialize
      @db = PG.connect(host: 'localhost', dbname: 'bartender')
      build_tables
    end
    
    # these methods create the tables in your db if they
    # dont already exist
    def build_tables
      @db.exec(%q[
        CREATE TABLE IF NOT EXISTS ingredients(
          id serial NOT NULL PRIMARY KEY,
          name varchar(30) NOT NULL UNIQUE,
        )])
  
      @db.exec(%q[
        CREATE TABLE IF NOT EXISTS drinks(
          id serial NOT NULL PRIMARY KEY,
          drink_name varchar(30) NOT NULL UNIQUE,
          ingredient_with_amount text[][], 
          directions text
        )])
        #ingredient with amount is a 3 by n two dimensional array 
        #[0][n] corresponds to the ingredient ID of an ingredient
        #[1][n] corresponds to the numerical amount on the ingredient (It's text, but separated for a to_int)
        #[2][n] corresponds to the units associated with the ingredient amount.
  
    end
    
    # Breed Methods

    def create_breed(breed, price)
      @db.exec_params(%q[
        INSERT INTO breeds (breed, price)
        VALUES ($1, $2);
      ], [breed, price])
    end

    def self.set_status(id, status)
      @db.exec_params(%q[
        UPDATE purchase_orders SET status = $2
        WHERE id = $1;
        ], id, status)
    end
  end

  # singleton creation
  def self.dbi
    @__db_instance ||= DBI.new
  end
end
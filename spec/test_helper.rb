module TestHelper
  #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with symbols and integers
  def hash_keys_and_values_to_string(hash)
    Hash[hash.map { |k,v| [k.to_s, v.to_s] }]
  end

  def hash_keys_to_string(hash)
    Hash[hash.map { |k,v| [k.to_s, v] }]
  end
end

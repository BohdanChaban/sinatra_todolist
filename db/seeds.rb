Task.delete_all
List.delete_all
Task.reset_autoincrement
List.reset_autoincrement

colors = %w[54b2a1 95d5cf 809bbe 98d2f3 80bf86 a3d49f]

puts 'Creating sample lists'
%w[Todo Supermarket].each_with_index do |list, index|
  List.find_or_create_by(name: list, color: colors[index])
end

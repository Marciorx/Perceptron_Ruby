# Perceptron function
class Perceptron

  @w1 = rand(0.0..1.0)
  @w2 = rand(0.0..1.0)
  @w3 = rand(0.0..1.0)
  @@aprendizagem = 0.2
  @@treinamento_perceptron_finalizado = false
  # @@registros_validados = []
  # x1 = 0.0
  # x2 = 0.0
  # vies = 1
  # saida = 0
  @@speed = 0.5
  @@pesos = [@w1, @w2, @w3]

  def intro
    puts
    puts
    puts "-----------------------------------------PERCEPTRON------------------------------------------"
    puts "-                                                                                           -"
    puts "-                                                                                           -"
    puts "-                   Disciplina de Inteligencia Artificial - Prof. Alexandre                 -"
    puts "-                                                                                           -"
    puts "-                                                                                           -"
    puts "---------------------------------------------------------------------------------------------"
    puts "-                                                                                           -"
    puts "-                      O valor inicial dos pesos é [#{'%.2f' % @@pesos[0]}, #{'%.2f' % @@pesos[1]}, #{'%.2f' % @@pesos[2]}]                       -"
    puts "-                                                                                           -"
    puts "---------------------------------------------------------------------------------------------"
    puts
    puts
  end
    
  
  def ativacao(x1, w1, x2, w2, w3)
    soma = 0
    soma = x1 * w1.to_f + x2 * w2.to_f + 1 * w3.to_f
    puts "O valor da entrada é: [#{x1}, #{x2}], os valores do peso são: [#{'%.2f' % @@pesos[0]}, #{'%.2f' % @@pesos[1]}, #{'%.2f' % @@pesos[2]}] e o valor de saída é: #{(soma > 0 or soma == 0 )? out = 1 : out = -1}"
    (soma > 0 or soma == 0 )? out = 1 : out = -1
  end


  def classifica_corretamente?(saida, esperado)
    saida == esperado
  end

  #   calculo_peso(@@pesos, @@aprendizagem, esperado, saida, dado)
  def calculo_peso(peso, aprend, esperado, saida, entrada)
    # resultado = 0
    # aprend_entrada = 0
    resultado = (esperado - saida) * aprend
    aprend_entrada = entrada.each.map {|x| x * resultado}
    @@pesos = [peso,aprend_entrada].transpose.map(&:sum)
  end

  def treinamento(dados)
    intro
    print "Entre com o valor desejado para velocidade de apresentação: (digite valores entre 0 e 1, sendo 0 o mais rapido e 1 o mais lento.) "
    
    @@speed = gets.chomp.to_f
    while @@treinamento_perceptron_finalizado == false do
      treinamento_perceptron(dados)
    end
    
    puts "O valor dos pesos que classificam corretamente são: [#{'%.2f' % @@pesos[0]}, #{'%.2f' % @@pesos[1]}, #{'%.2f' % @@pesos[2]}]"
  end


  def treinamento_perceptron(dados)
    error_count = 0
    # dados.each do |i|
    #   @@registros_validados.append(true)
    # end
    
    # while @@registros_validados.length > 0 do
      dados.each do |dado|
        # registro_classificado = false
        # until registro_classificado == true
          saida = ativacao(dado[0], '%.2f' % @@pesos[0], dado[1], '%.2f' % @@pesos[1], '%.2f' % @@pesos[2])
          esperado = dado.last

          if classifica_corretamente?(saida, esperado)
            puts "O registro #{dado} foi classificado corretamente"
            puts
            sleep(@@speed)
            # @@registros_validados.pop
            # registro_classificado = true
          else
            error_count += 1
            @@pesos = calculo_peso(@@pesos, @@aprendizagem, esperado, saida, dado)
            puts "O registro #{dado} NÃO foi classificado corretamente"
            puts
            puts "Recalculando o valor dos pesos..."
            puts
            sleep(@@speed)
            # @@registros_validados.clear
          end
        # end
      end
        puts        
        puts
        puts "Foram feitas #{error_count} mudanças de peso."
        puts 
        puts "--------------------------------------------------------------------------------------------------------------------------"
        puts 
    # end
  if error_count == 0  
    return @@treinamento_perceptron_finalizado = true
  end
  end

  def prediction(a,b)
    saida = ativacao(a, @@pesos[0], b, @@pesos[1], @@pesos[2])
    # puts "Para a entrada [#{a.to_s}, #{b.to_s}] o valor de saída é: #{saida.to_s}."
  end
end

#DataSet.all.each_with_index {|d, index| dados_entrada[index] = [d.x1, d.x2, d.Saida]}
dados_entrada = [  [1, 1, 1], [9.4, 6.4, -1], [2.5, 2.1, 1], [8, 7.7, -1], [0.5, 2.2, 1], [7.9, 8.4, -1], [7, 7, -1], [2.8, 0.8, 1], [1.2, 3, 1], [7.8, 6.1, -1] ]

perceptron = Perceptron.new

perceptron.treinamento(dados_entrada)
puts
puts
puts "Por favor, entre com os valores para realizar a predição: "
puts
print "Valor 1: "
a = gets.chomp.to_f
puts
print "Valor 2: "
b = gets.chomp.to_f
puts

perceptron.prediction(a, b)

# saida = ativacao(dados[index][0], @@pesos[0], dados[index][1],@@pesos[1], @@pesos[2])
# resultado_obtido = ativacao(dados_entrada[i][0], @w1, dados_entrada[i][1], @w2, vies, @w3)

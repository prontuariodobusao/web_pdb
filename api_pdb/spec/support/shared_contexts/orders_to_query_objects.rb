require 'rails_helper'

shared_context 'query object models' do
  let!(:s1) { create(:status, name: 'Aguardando') }
  let!(:s2) { create(:status, name: 'Manutenção') }
  let!(:s3) { create(:status, name: 'Cancelada') }
  let!(:s4) { create(:status, name: 'Finalizada') }

  let(:status1) { Status.find 1 }
  let(:status2) { Status.find 2 }
  let(:status3) { Status.find 3 }
  let(:status4) { Status.find 4 }

  let(:enginer) { create(:category, name: 'MOTOR') }
  let(:energy) { create(:category, name: 'ELÉTRICA') }
  let(:bodywork) { create(:category, name: 'CARROCERIA') }
  let(:suspension) { create(:category, name: 'SUSPENSÃO') }
  # Create problems
  let(:problem1) { create(:problem, description: 'Óleo baixo', priority: :high, category: enginer) }
  let(:problem2) { create(:problem, description: 'Perda de força', priority: :high, category: enginer) }
  let(:problem3) { create(:problem, description: 'Aquecendo', priority: :high, category: enginer) }
  let(:problem4) { create(:problem, description: 'Falhando', priority: :high, category: enginer) }
  let(:problem5) { create(:problem, description: 'Cortando o óleo/bico injetor', priority: :high, category: enginer) }
  let(:problem6) { create(:problem, description: 'Fumaçando', priority: :high, category: enginer) }
  let(:problem7) { create(:problem, description: 'Sirene', priority: :normal, category: energy) }
  let(:problem8) { create(:problem, description: 'Faróis', priority: :normal, category: energy) }
  let(:problem9) { create(:problem, description: 'Pisca', priority: :normal, category: energy) }
  let(:problem10) { create(:problem, description: 'Controcity', priority: :normal, category: energy) }
  let(:problem11) { create(:problem, description: 'Luz de salão', priority: :high, category: energy) }
  let(:problem12) { create(:problem, description: 'Buzina', priority: :normal, category: energy) }
  let(:problem13) { create(:problem, description: 'Janela quebrada', priority: :easy, category: bodywork) }
  let(:problem14) { create(:problem, description: 'Banco com folga ou sujo', priority: :high, category: bodywork) }
  let(:problem15) { create(:problem, description: 'Sem fumê', priority: :normal, category: bodywork) }
  let(:problem16) do
    create(:problem, description: 'Porta não abre ou fecha direito', priority: :high, category: bodywork)
  end
  let(:problem17) { create(:problem, description: 'Elevador Cadeirante', priority: :high, category: bodywork) }
  let(:problem18) { create(:problem, description: 'Mola Mestre', priority: :high, category: suspension) }
  let(:problem19) { create(:problem, description: 'Amortecedor', priority: :high, category: suspension) }
  let(:problem20) { create(:problem, description: 'Feixo de molas', priority: :normal, category: suspension) }
  let(:problem21) { create(:problem, description: 'Barra estabilizadora', priority: :high, category: suspension) }

  # create vehicles
  let!(:vehicle1) do
    create(:vehicle, km: 5000, car_number: '04383', oil_date: '13/08/2021', tire_date: '23/07/2021',
                     revision_date: '21/07/2021')
  end
  let(:vehicle2) do
    create(:vehicle, km: 5000, car_number: '04384', oil_date: '06/08/2021', tire_date: '09/08/2021',
                     revision_date: '22/07/2021')
  end
  let(:vehicle3) do
    create(:vehicle, km: 5000, car_number: '04385', oil_date: '26/07/2021', tire_date: '20/07/2021',
                     revision_date: '11/08/2021')
  end
  let(:vehicle4) do
    create(:vehicle, km: 5000, car_number: '04386', oil_date: '30/07/2021', tire_date: '19/07/2021',
                     revision_date: '24/07/2021')
  end
  let!(:vehicle5) do
    create(:vehicle, km: 5000, car_number: '04387', oil_date: '23/07/2021', tire_date: '29/07/2021',
                     revision_date: '30/07/2021')
  end
  let(:vehicle6) do
    create(:vehicle, km: 5000, car_number: '04388', oil_date: '19/07/2021', tire_date: '16/08/2021',
                     revision_date: '12/08/2021')
  end
  let(:vehicle7) do
    create(:vehicle, km: 5000, car_number: '04389', oil_date: '09/08/2021', tire_date: '03/08/2021',
                     revision_date: '15/08/2021')
  end
  let(:vehicle8) do
    create(:vehicle, km: 5000, car_number: '04390', oil_date: '04/08/2021', tire_date: '20/07/2021',
                     revision_date: '25/07/2021')
  end
  let(:vehicle9) do
    create(:vehicle, km: 5000, car_number: '04391', oil_date: '05/08/2021', tire_date: '01/08/2021',
                     revision_date: '25/07/2021')
  end
  let(:vehicle10) do
    create(:vehicle, km: 5000, car_number: '04392', oil_date: '27/07/2021', tire_date: '20/07/2021',
                     revision_date: '26/07/2021')
  end
  let(:vehicle11) do
    create(:vehicle, km: 5000, car_number: '04393', oil_date: '27/07/2021', tire_date: '07/08/2021',
                     revision_date: '03/08/2021')
  end
  let(:vehicle12) do
    create(:vehicle, km: 5000, car_number: '04394', oil_date: '28/07/2021', tire_date: '24/07/2021',
                     revision_date: '07/08/2021')
  end
  let(:vehicle13) do
    create(:vehicle, km: 5000, car_number: '04360', oil_date: '24/07/2021', tire_date: '29/07/2021',
                     revision_date: '10/08/2021')
  end
  let(:vehicle14) do
    create(:vehicle, km: 5000, car_number: '04361', oil_date: '26/07/2021', tire_date: '04/08/2021',
                     revision_date: '16/08/2021')
  end
  let(:vehicle15) do
    create(:vehicle, km: 5000, car_number: '04362', oil_date: '04/08/2021', tire_date: '05/08/2021',
                     revision_date: '19/07/2021')
  end
  let(:vehicle16) do
    create(:vehicle, km: 5000, car_number: '042345', oil_date: '16/08/2021', tire_date: '16/08/2021',
                     revision_date: '27/07/2021')
  end

  let(:order1) do
    create(:order, reference: 'OS_00001/2021', km: 100_000, state: 'opened', problem_id: problem17.id, vehicle_id: vehicle4.id, status_id: status2.id,
                   created_at: '11/08/2021', updated_at: '11/08/2021')
  end
  let(:order2) do
    create(:order, reference: 'OS_00002/2021', km: 100_000, state: 'opened', problem_id: problem17.id, vehicle_id: vehicle1.id, status_id: status2.id,
                   created_at: '11/08/2021', updated_at: '18/08/2021')
  end
  let(:order3) do
    create(:order, reference: 'OS_00003/2021', km: 150_000, state: 'closed', problem_id: problem17.id, vehicle_id: vehicle2.id, status_id: status3.id,
                   created_at: '11/08/2021', updated_at: '17/08/2021')
  end
  let(:order4) do
    create(:order, reference: 'OS_00004/2021', km: 238_700, state: 'closed', problem_id: problem17.id, vehicle_id: vehicle3.id, status_id: status4.id,
                   created_at: '11/08/2021', updated_at: '19/08/2021')
  end
  let(:order5) do
    create(:order, reference: 'OS_00005/2021', km: 302_090, state: 'closed', problem_id: problem13.id, vehicle_id: vehicle4.id, status_id: status4.id,
                   created_at: '11/08/2021', updated_at: '17/08/2021')
  end
  let(:order6) do
    create(:order, reference: 'OS_00006/2021', km: 160_000, state: 'closed', problem_id: problem13.id, vehicle_id: vehicle5.id, status_id: status3.id,
                   created_at: '11/08/2021', updated_at: '20/08/2021')
  end
  let(:order7) do
    create(:order, reference: 'OS_00007/2021', km: 600_909, state: 'opened', problem_id: problem14.id, vehicle_id: vehicle6.id, status_id: status2.id,
                   created_at: '11/08/2021', updated_at: '18/08/2021')
  end
  let(:order8) do
    create(:order, reference: 'OS_00008/2021', km: 588_000, state: 'closed', problem_id: problem16.id, vehicle_id: vehicle7.id, status_id: status3.id,
                   created_at: '11/08/2021', updated_at: '19/08/2021')
  end
  let(:order9) do
    create(:order, reference: 'OS_00009/2021', km: 588_000, state: 'closed', problem_id: problem16.id, vehicle_id: vehicle8.id, status_id: status4.id,
                   created_at: '11/08/2021', updated_at: '20/08/2021')
  end
  let(:order10) do
    create(:order, reference: 'OS_00010/2021', km: 485_000, state: 'closed', problem_id: problem7.id, vehicle_id: vehicle9.id, status_id: status3.id,
                   created_at: '11/08/2021', updated_at: '19/08/2021')
  end
  let(:order11) do
    create(:order, reference: 'OS_00011/2021', km: 298_987, state: 'closed', problem_id: problem7.id, vehicle_id: vehicle1.id, status_id: status3.id,
                   created_at: '11/08/2021', updated_at: '20/08/2021')
  end
  let(:order12) do
    create(:order, reference: 'OS_00012/2021', km: 309_897, state: 'closed', problem_id: problem7.id, vehicle_id: vehicle1.id, status_id: status4.id,
                   created_at: '11/08/2021', updated_at: '19/08/2021')
  end
  let(:order13) do
    create(:order, reference: 'OS_00013/2021', km: 578_231, state: 'closed', problem_id: problem8.id, vehicle_id: vehicle1.id, status_id: status3.id,
                   created_at: '11/08/2021', updated_at: '20/08/2021')
  end
  let(:order14) do
    create(:order, reference: 'OS_00014/2021', km: 400_000, state: 'closed', problem_id: problem10.id, vehicle_id: vehicle1.id, status_id: status4.id,
                   created_at: '11/08/2021', updated_at: '19/08/2021')
  end
  let(:order15) do
    create(:order, reference: 'OS_00015/2021', km: 309_000, state: 'closed', problem_id: problem11.id, vehicle_id: vehicle1.id, status_id: status4.id,
                   created_at: '11/08/2021', updated_at: '20/08/2021')
  end
  let(:order16) do
    create(:order, reference: 'OS_00016/2021', km: 500_211, state: 'opened', problem_id: problem19.id, vehicle_id: vehicle1.id, status_id: status2.id,
                   created_at: '11/08/2021', updated_at: '19/08/2021')
  end
  let(:order17) do
    create(:order, reference: 'OS_00017/2021', km: 490_000, state: 'closed', problem_id: problem18.id, vehicle_id: vehicle2.id, status_id: status3.id,
                   created_at: '11/08/2021', updated_at: '19/08/2021')
  end
  let(:order18) do
    create(:order, reference: 'OS_00018/2021', km: 601_098, state: 'opened', problem_id: problem2.id, vehicle_id: vehicle3.id, status_id: status2.id,
                   created_at: '11/08/2021', updated_at: '20/08/2021')
  end
  let(:order19) do
    create(:order, reference: 'OS_00019/2021', km: 501_001, state: 'closed', problem_id: problem2.id, vehicle_id: vehicle4.id, status_id: status4.id,
                   created_at: '11/08/2021', updated_at: '20/08/2021')
  end
  let(:order20) do
    create(:order, reference: 'OS_00020/2021', km: 600_098, state: 'closed', problem_id: problem6.id, vehicle_id: vehicle5.id, status_id: status3.id,
                   created_at: '11/08/2021', updated_at: '20/08/2021')
  end
  let(:order21) do
    create(:order, reference: 'OS_00021/2021', km: 308_909, state: 'closed', problem_id: problem6.id, vehicle_id: vehicle6.id, status_id: status4.id,
                   created_at: '11/08/2021', updated_at: '18/08/2021')
  end
  let(:order22) do
    create(:order, reference: 'OS_00022/2021', km: 2345, state: 'opened', problem_id: problem2.id, vehicle_id: vehicle1.id, status_id: status4.id,
                   created_at: '03/09/2021', updated_at: '03/09/2021')
  end
  let(:order23) do
    create(
      :order,
      reference: 'OS_00023/2021',
      km: 9696,
      description: 'O careo está pulando muito',
      state: 'opened',
      problem_id: problem18.id,
      vehicle_id: vehicle1.id,
      status_id: status1.id,
      created_at: '02/09/2021',
      updated_at: '02/09/2021'
    )
  end

  let(:history1) do
    create(:history,
           km: 100_000,
           description: 'Elevador',
           status_id: status1.id,
           order_id: order1.id,
           created_at: '11/08/2021')
  end
  let(:history2) do
    create(:history,
           km: 100_000,
           description: 'Por favor, realizar...',
           status_id: status2.id,
           order_id: order1.id,
           created_at: '11/08/2021')
  end
  let(:history3) do
    create(:history,
           km: 100_000,
           description: 'Rampa não desce ou sobe',
           status_id: status1.id,
           order_id: order2.id,
           created_at: '11/08/2021')
  end
  let(:history4) do
    create(:history,
           km: 150_000,
           description: 'Acionador elétrico não funciona.',
           status_id: status1.id,
           order_id: order3.id,
           created_at: '11/08/2021')
  end
  let(:history5) do
    create(:history,
           km: 238_700,
           description: 'Sujeira (terra/poeira) nas engrenagem.',
           status_id: status1.id,
           order_id: order4.id,
           created_at: '11/08/2021')
  end
  let(:history6) do
    create(:history,
           km: 302_090,
           description: 'Vandalismo',
           status_id: status1.id,
           order_id: order5.id,
           created_at: '11/08/2021')
  end
  let(:history7) do
    create(:history,
           km: 160_000,
           description: 'Colisão na garagem.',
           status_id: status1.id,
           order_id: order6.id,
           created_at: '11/08/2021')
  end
  let(:history8) do
    create(:history,
           km: 600_909,
           description: 'Regulagem quebrada.',
           status_id: status1.id,
           order_id: order7.id,
           created_at: '11/08/2021')
  end
  let(:history9) do
    create(:history,
           km: 588_000,
           description: 'Problema no macaco hidráulico.',
           status_id: status1.id,
           order_id: order8.id,
           created_at: '11/08/2021')
  end
  let(:history10) do
    create(:history,
           km: 588_000,
           description: 'Vazamento de ar.',
           status_id: status1.id,
           order_id: order9.id,
           created_at: '11/08/2021')
  end
  let(:history11) do
    create(:history,
           km: 485_000,
           description: 'Relé queimado.',
           status_id: status1.id,
           order_id: order10.id,
           created_at: '11/08/2021')
  end
  let(:history12) do
    create(:history,
           km: 298_987,
           description: 'Fusível queimado.',
           status_id: status1.id,
           order_id: order11.id,
           created_at: '11/08/2021')
  end
  let(:history13) do
    create(:history,
           km: 309_897,
           description: 'Vandalismo.',
           status_id: status1.id,
           order_id: order12.id,
           created_at: '11/08/2021')
  end
  let(:history14) do
    create(:history,
           km: 578_231,
           description: 'Lampada queimada.',
           status_id: status1.id,
           order_id: order13.id,
           created_at: '11/08/2021')
  end
  let(:history15) do
    create(:history,
           km: 400_000,
           description: 'Problema no display.',
           status_id: status1.id,
           order_id: order14.id,
           created_at: '11/08/2021')
  end
  let(:history16) do
    create(:history,
           km: 309_000,
           description: 'Lampada queimada.',
           status_id: status1.id,
           order_id: order15.id,
           created_at: '11/08/2021')
  end
  let(:history17) do
    create(:history,
           km: 500_211,
           description: 'Amortecedor estourado.',
           status_id: status1.id,
           order_id: order16.id,
           created_at: '11/08/2021')
  end
  let(:history18) do
    create(:history,
           km: 490_000,
           description: 'Excesso de peso.',
           status_id: status1.id,
           order_id: order17.id,
           created_at: '11/08/2021')
  end
  let(:history19) do
    create(:history,
           km: 601_098,
           description: 'Óleo baixo.',
           status_id: status1.id,
           order_id: order18.id,
           created_at: '11/08/2021')
  end
  let(:history20) do
    create(:history,
           km: 501_001,
           description: 'Vazamento de óleo lubrificante.',
           status_id: status1.id,
           order_id: order19.id,
           created_at: '11/08/2021')
  end
  let(:history21) do
    create(:history,
           km: 600_098,
           description: 'Excesso de óleo.',
           status_id: status1.id,
           order_id: order20.id,
           created_at: '11/08/2021')
  end
  let(:history22) do
    create(:history,
           km: 308_909,
           description: 'Problema na turbina.',
           status_id: status1.id,
           order_id: order21.id,
           created_at: '11/08/2021')
  end
  let(:history23) do
    create(:history,
           km: 150_000,
           description: 'Cancelada...',
           status_id: status3.id,
           order_id: order3.id,
           created_at: '17/08/2021')
  end
  let(:history24) do
    create(:history,
           km: 302_090,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order5.id,
           created_at: '17/08/2021')
  end
  let(:history25) do
    create(:history,
           km: 302_090,
           description: 'Realizado com sucesso...',
           status_id: status4.id,
           order_id: order5.id,
           created_at: '17/08/2021')
  end
  let(:history26) do
    create(:history,
           km: 100_000,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order2.id,
           created_at: '18/08/2021')
  end
  let(:history27) do
    create(:history,
           km: 600_909,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order7.id,
           created_at: '18/08/2021')
  end
  let(:history28) do
    create(:history,
           km: 308_909,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order21.id,
           created_at: '18/08/2021')
  end
  let(:history29) do
    create(:history,
           km: 308_909,
           description: 'Realizar...',
           status_id: status4.id,
           order_id: order21.id,
           created_at: '18/08/2021')
  end
  let(:history30) do
    create(:history,
           km: 238_700,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order4.id,
           created_at: '19/08/2021')
  end
  let(:history31) do
    create(:history,
           km: 238_700,
           description: 'Finalizada...',
           status_id: status4.id,
           order_id: order4.id,
           created_at: '19/08/2021')
  end
  let(:history32) do
    create(:history,
           km: 588_000,
           description: 'Cancelada...',
           status_id: status3.id,
           order_id: order8.id,
           created_at: '19/08/2021')
  end
  let(:history33) do
    create(:history,
           km: 485_000,
           description: 'Cancelada...',
           status_id: status3.id,
           order_id: order10.id,
           created_at: '19/08/2021')
  end
  let(:history34) do
    create(:history,
           km: 309_897,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order12.id,
           created_at: '19/08/2021')
  end
  let(:history35) do
    create(:history,
           km: 309_897,
           description: 'Finalizada...',
           status_id: status4.id,
           order_id: order12.id,
           created_at: '19/08/2021')
  end
  let(:history36) do
    create(:history,
           km: 400_000,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order14.id,
           created_at: '19/08/2021')
  end
  let(:history37) do
    create(:history,
           km: 400_000,
           description: 'Finalizada...',
           status_id: status4.id,
           order_id: order14.id,
           created_at: '19/08/2021')
  end
  let(:history38) do
    create(:history,
           km: 500_211,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order16.id,
           created_at: '19/08/2021')
  end
  let(:history39) do
    create(:history,
           km: 490_000,
           description: 'Cancelada...',
           status_id: status3.id,
           order_id: order17.id,
           created_at: '19/08/2021')
  end
  let(:history40) do
    create(:history,
           km: 160_000,
           description: 'Cancelada...',
           status_id: status3.id,
           order_id: order6.id,
           created_at: '20/08/2021')
  end
  let(:history41) do
    create(:history,
           km: 588_000,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order9.id,
           created_at: '20/08/2021')
  end
  let(:history42) do
    create(:history,
           km: 588_000,
           description: 'Finalizada...',
           status_id: status4.id,
           order_id: order9.id,
           created_at: '20/08/2021')
  end
  let(:history43) do
    create(:history,
           km: 298_987,
           description: 'Cancelada...',
           status_id: status3.id,
           order_id: order11.id,
           created_at: '20/08/2021')
  end
  let(:history44) do
    create(:history,
           km: 578_231,
           description: 'Cancelada...',
           status_id: status3.id,
           order_id: order13.id,
           created_at: '20/08/2021')
  end
  let(:history45) do
    create(:history,
           km: 309_000,
           description: 'Finalizada...',
           status_id: status2.id,
           order_id: order15.id,
           created_at: '20/08/2021')
  end
  let(:history46) do
    create(:history,
           km: 309_000,
           description: 'Finalizada...',
           status_id: status4.id,
           order_id: order15.id,
           created_at: '20/08/2021')
  end
  let(:history47) do
    create(:history,
           km: 601_098,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order18.id,
           created_at: '20/08/2021')
  end
  let(:history48) do
    create(:history,
           km: 600_098,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order20.id,
           created_at: '20/08/2021')
  end
  let(:history49) do
    create(:history,
           km: 600_098,
           description: 'Cancelada...',
           status_id: status3.id,
           order_id: order20.id,
           created_at: '20/08/2021')
  end
  let(:history50) do
    create(:history,
           km: 501_001,
           description: 'Manutencao...',
           status_id: status2.id,
           order_id: order19.id,
           created_at: '20/08/2021')
  end
  let(:history51) do
    create(:history,
           km: 501_001,
           description: 'Finalizada...',
           status_id: status4.id,
           order_id: order19.id,
           created_at: '20/08/2021')
  end
  let(:history52) do
    create(:history,
           km: 56_555,
           description: '',
           status_id: status1.id,
           order_id: order22.id,
           created_at: '01/09/2021')
  end
  let(:history53) do
    create(:history,
           km: 9696,
           description: 'O careo está pulando muito',
           status_id: status1.id,
           order_id: order23.id,
           created_at: '02/09/2021')
  end
  let(:history54) do
    create(:history,
           km: 56_555,
           description: 'Trocar e ajustar a mola',
           status_id: status2.id,
           order_id: order22.id,
           created_at: '02/09/2021')
  end
  let(:history55) do
    create(:history,
           km: 56_555,
           description: 'Foi aplicado um filtro no motor',
           status_id: status4.id,
           order_id: order22.id,
           created_at: '02/09/2021')
  end

  let!(:orders) do
    [
      order1,
      order2,
      order3,
      order4,
      order5,
      order6,
      order7,
      order8,
      order9,
      order10,
      order11,
      order12,
      order13,
      order14,
      order15,
      order16,
      order17,
      order18,
      order19,
      order20,
      order21,
      order22,
      order23
    ]
  end
  let!(:histories) do
    [
      history1,
      history2,
      history3,
      history4,
      history5,
      history6,
      history7,
      history8,
      history9,
      history10,
      history11,
      history12,
      history13,
      history14,
      history15,
      history16,
      history17,
      history18,
      history19,
      history20,
      history21,
      history22,
      history23,
      history24,
      history25,
      history26,
      history27,
      history28,
      history29,
      history30,
      history31,
      history32,
      history33,
      history34,
      history35,
      history36,
      history37,
      history38,
      history39,
      history40,
      history41,
      history42,
      history43,
      history44,
      history45,
      history46,
      history47,
      history48,
      history49,
      history50,
      history51,
      history52,
      history53,
      history54,
      history55
    ]
  end
end

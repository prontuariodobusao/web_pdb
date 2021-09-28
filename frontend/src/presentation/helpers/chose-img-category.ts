import imgCarroceria from '../assets/images/carroceria.jpeg'
import imgEletrica from '../assets/images/eletrica.jpeg'
import imgMotor from '../assets/images/motor.jpeg'
import imgSuspensao from '../assets/images/suspensao.jpeg'

export const choseImgCategory = (id: number): string => {
  switch (id) {
    case 1:
      return imgMotor
    case 2:
      return imgEletrica
    case 3:
      return imgCarroceria
    default:
      return imgSuspensao
  }
}

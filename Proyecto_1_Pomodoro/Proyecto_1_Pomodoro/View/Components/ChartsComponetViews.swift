//
//  ChartsComponetViews.swift
//  Proyecto_1_Pomodoro
//
//  Created by Esteban Pérez Castillejo on 26/1/25.
//

import SwiftUI
import Charts


// Metricas Con datos ficticios
struct ChartComponetView: View {
    @State var sampleAvisos: [ModelShartsSmok] = sample_Avisos
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Gráfico de Avisos por Día")
                .font(.headline.bold()).offset(x: 10, y: 10)
            Chart {
                ForEach(sampleAvisos) { aviso in
                    BarMark(
                        x: .value("Día", aviso.dia),      // Eje X: Días de la semana
                        y: .value("Avisos", aviso.avisos) // Eje Y: Cantidad de avisos
                    )
                    .foregroundStyle(.blue.gradient)
                }
            }
            .chartYAxisLabel("Cantidad de Avisos") // Etiqueta del eje Y
            .chartXAxisLabel("Días de la Semana")  // Etiqueta del eje X
            .chartYScale(domain: 0...6)           // Escala del eje Y ajustada a los datos
            .frame(height: 90)
            .padding()
        }.background{RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white.shadow(.drop(radius: 2)))
        }.padding(8)
            
    }
}


#Preview {
    ChartComponetView()
}

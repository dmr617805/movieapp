//
//  MovieSearchView.swift
//  movieapp
//
//  Created by m1 on 02/12/2024.
//

import SwiftUI


struct MovieSearchView: View {
    @Binding var isPresented : Bool
    @ObservedObject var viewModel: MovieViewModel
    @State var query = ""
    @State var includeAdult = false
    @State var year = ""
    
    
    var body: some View {
        
        NavigationView {
            Form{
                Section(header: Text("Detalles de la busqueda").font(.title3).padding(.vertical)
                )
                {
                    
                    VStack(spacing: 24.0){
                        
                        TextField("Título o palabras clave", text: $query)
                        
                        Toggle("Incluir contenido adulto", isOn: $includeAdult)
                        
                        TextField("Año de lanzamiento", text: $year).keyboardType(.numberPad)
                        
                    }.padding()
                    
                }
                
                
            }.navigationTitle("Buscar Pelicula")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancelar"){
                            isPresented = false
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Buscar"){
                            viewModel.searchMovies(query: query, includeAdult: includeAdult, year: year)
                            isPresented = false
                        }.disabled(query.isEmpty)
                    }
                }
        }
        
    }
}


#Preview {
    let viewModel = MovieViewModel()
    @State var showingSearchMovie =  false
    
    MovieSearchView(isPresented: $showingSearchMovie, viewModel: viewModel)
}

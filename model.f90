

! This module is a template for how to wrap a model so that it is 
! easy to use and couple with other models. 

module model 

    implicit none 

    type model_par_class 
        ! Derived type containing all model and domain-specific parameter options
    end type 

    type model_state_class 
        ! Derived type containing all variables that describe the state of the model
        ! in a given domain. This can include both prognostic model variables as
        ! well as prescribed boundary variables. Points, vectors and arrays
        ! should all be defined here if they are variables needed to represent the domain
        ! and should be saved between time steps. 
    end type 

    type model_class

        type(model_par_class)   :: par 
        type(model_state_class) :: now

    end type 

    private
    public :: model_par_class, model_state_class, model_physics_class 
    public :: model_alloc, model_dealloc, model_par_load
    public :: model_init, model_update, model_end


contains

    subroutine model_update(dom,year,day)

        implicit none 

        type(model_class) :: dom 
        integer :: year, day 

        ! Update model variables via calculations of model physics
        ! Arguments provide information the model needs concerning current time step, etc.
        ! Note: state variables that represent boundary conditions should
        ! already have been updated using an external exchange module.

        return

    end subroutine model_update

    subroutine model_init(dom)

        implicit none 

        type(model_class) :: dom 

        ! Initialize model variables on a given domain 'dom'
        ! Call `model_par_load` to load domain parameter values
        ! Call `model_alloc` to allocate state variables 

        return

    end subroutine model_init 

    subroutine model_end(dom)

        implicit none 

        type(model_class) :: dom 

        ! Finalize model variables on domain 'dom'
        ! Call `model_dealloc` to deallocate state variables 

        return

    end subroutine model_end 


    subroutine model_par_load(par,filename)

        implicit none 

        type(model_par_class) :: par 

        ! Load model parameters from 'filename' and store in the 
        ! derived par_class

        return 

    end subroutine model_par_load 

    subroutine model_alloc(now,nx,ny)

        implicit none 

        type(model_state_class) :: now 
        integer :: nx, ny 

        ! Allocate all state variables with dimensions, eg, (nx,ny)

        return

    end subroutine model_alloc 

    subroutine model_dealloc(now)

        implicit none 

        type(model_state_class) :: now 
        integer :: nx, ny 

        ! Deallocate all state variables to free memory

        return

    end subroutine model_dealloc 


end module model 


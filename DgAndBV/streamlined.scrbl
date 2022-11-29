#lang scribble/base
@(require racket scribble/core scribble/base scribble/html-properties)
@(require "defs.rkt" bystroTeX/common bystroTeX/slides (for-syntax bystroTeX/slides_for-syntax))
@; ---------------------------------------------------------------------------------------------------
@; User definitions:
@(bystro-set-css-dir (build-path (find-system-path 'home-dir) "a" "git" "amkhlv" "profiles" "writeup"))
@(define bystro-conf   
   (bystro (bystro-connect-to-server (build-path (find-system-path 'home-dir) ".config" "amkhlv" "latex2svg.xml"))
           "streamlined/formulas.sqlite"  ; name for the database
           "streamlined" ; directory where to store image files of formulas
           25  ; formula size
           (list 255 255 255) ; formula background color
           (list 0 0 0) ; formula foreground color
           2   ; automatic alignment adjustment
           0   ; manual alignment adjustment
           ))
@(define singlepage-mode #f)
@(bystro-def-formula "formula-enormula-humongula!")

@(require bystroTeX/bibtex truques/truques)

@;use-LaTeX-preamble|{\newcommand{\caixa}[1]{\fbox{$\displaystyle #1$}}}|

@title[#:style '(no-toc no-sidebar)]{Insertion of vertex operators using BV formalism}

@bystro-source[]

@bystro-ribbon[]

@bystro-abstract{
                 We develop a general framework for the insertion of
                 vertex operator on the string worldsheet, in BV formalism. Such
                 insertions correspond to deformations of the Master Action which
                 breaks the gauge symmetry to a subgroup, and then restoring the full
                 gauge symmetry by integrating over a cycle in the space of Lagrangian
                 submanifolds.  We provide the general construction, global on the moduli space, which was previously conjectured
                 in a form local on the worldsheet.  We explain how the enhancement of
                 the gauge symmetry in equivariant BV formalism can be seen as an application
                 of the general idea of BV effective action.
                 We derive an integral formula for the deformation
                 of the contraction operator due to the vertex insertion.
                 }


@bystro-toc[]

@bystro-ribbon[]


@page["Introduction" #:tag "Introduction" #:showtitle #t]

String amplitudes are computed in perturbation theory by integrating the CFT correlators
of vertex operators over the moduli space of Riemann surfaces.
A mathematical abstraction for the string measure within the BV formalism was outlined in
@cite{Schwarz:2000ct}
and further developed in @cite{Mikhailov:2016myt},@cite{Mikhailov:2016rkp}.
An important role is played by the equivariant BV formalism developed in
@cite{Nersessian:1993me}, @cite{Nersessian:1993eq}, @cite{Nersessian:1995yt},
@cite{Getzler:2015jrr}, @cite{Getzler:2016fek}, @cite{Cattaneo:2016zrn}, @cite{Getzler:2018sbh},
@cite{Bonechi:2019dqk}. In particular, the relation to some differential graded Lie superalgebras
introduced in @cite{Alekseev:2010gr} was discussed in @cite{Mikhailov:2020lzo}. 

In this paper we will continue the study of equivariant BV in the context of string measure.
We will mostly concentrate on the ``covariant insertion'' of vertex operators
on the string worldsheet @cite{Polchinski:1988jq},@cite{Nelson:1988ic}.
Our approach emphasizes the gauge symmetries of the string sigma-model, which include worldsheet diffeomorphisms.
In BV formalism, gauge symmetries are exact in the following sense. If @f{\xi} is an infinitesimal
gauge symmetry, then its BV Hamiltonian @f{\underline{\xi}} is:
@e[#:label "IntroExactCg"]{
   \underline{\xi} = \Delta \underline{i_1\langle \xi\rangle}
   }
where @f{\Delta} is the BV Odd Laplace operator
(roughly speaking it is the odd Poisson bracket with the BV Master Action, @f{\{S_{\rm BV},\_\}})
and @f{\underline{i_1\langle\xi\rangle}} some function on the BV phase space linearly dependent on @f{\xi} as a parameter.
For example, in the case of bosonic string, @f{\xi} is a vector field on the string worldsheet @f{\Sigma},
and @f{i_1} is
@e[#:label "IntroI1"
   ]{
     \underline{i_1\langle\xi\rangle} = \int_{\Sigma} c^{\star}_{\alpha}\xi^{\alpha}
     }
where @f{c^{\star}} is the antifield of the @f{c}-ghost. Physical states of the bosonic string
correspond to the ghost number two vertex operators. For example, the tachyon vertex is:
@e{
   V = c\bar{c} e^{ikx}
   }
This is inserted at a point on the string worldsheet, but one should also integrate over the position
of the insertion. The integration procedure involves ``stripping'' the @f{c}-ghosts:
@e{
   \int_{\Sigma} d^2z e^{ikx} = \int_{\Sigma} U
   }
where the @bold{integrated} vertex operator (a two-form on @f{\Sigma}) is defined as follows:
@e[#:label "IntroIntegratedVertex"
   ]{
     U = \{c^{\star}dz,\{\bar{c}^{\star} d\bar{z},V\}\}
     }
When we insert the ``unintegrated'' vertex operator @f{V}, the diffeomorphism symmetry gets broken down
to those maps which preserve the point of insertion.
Then, when we integrate over the worldsheet metrics, we effectively integrate over the position
of the insertion point, and the full diffeomorphism symmetry is restored.


The relation between Eq. (@ref{IntroIntegratedVertex}) and Eq. (@ref{IntroI1}) can be generalized to other
string theories where Eq. (@ref{IntroI1}) is more complicated:
@(align
  r.l.n
  `(@,f{\underline{\xi}\;=\;}
       @,f{\Delta \underline{i(\xi)} + {1\over 2}\underline{[i(\xi),i(\xi)]}}
       @,label{IntroExactDg}
       )
  `(@,f{i(\xi) \;=\;}
       @,f{i_1\langle\xi\rangle + i_2\langle\xi\otimes\xi\rangle + \ldots}
       "")
  )
(We use angular brackets around the argument of a function, when the function is linear.)
This was previously discussed in @cite{Mikhailov:2020lzo}, but the consideration was local on the
space of metrics, and the analogue of Eq. (@ref{IntroIntegratedVertex}) was only conjectured.
Here we derive the ``global'' relation combining the ``vertical'' integration
over the position of the insertion point with the integration over the moduli space of Riemann surfaces.

We do not know explicit examples of string theories where @f{i_{\geq 2}} is nonzero, but we suspect that
this is what happens in the pure spinor formalism
(see 〚@seclink["DeformationOfI"]{@secref{DeformationOfI}}〛).
One example with nonzero @f{i_2} was recently discussed
(not for a string sigma-model) in @cite{Bonechi:2022aji}.


@page[@elem{Half-densities and their deformations} #:tag "HalfDensitiesAndDeformations" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 "Odd Laplace operator" #:tag "sec:OddLaplaceOperator"]

Let @f{M} be a supermanifold with an odd symplectic structure.
We call it the ``BV phase space''.
Let @f{\mathfrak a} be a Lie superalgebra of functions on @f{M}, with
opposite statistics, the Lie operation being the BV Poisson bracket @f{\{,\}}.
@bystro-margin-note{@f{M}, @f{\mathfrak a}, @f{\{,\}}}
In Darboux coordinates:
@e[#:label "DarbouxCoordinates"]{
   \{\phi^{\star}_A,\phi^B\} = \delta_A^B
   }
Half-density @f{\rho_{1/2}} on @f{M} is a scalar function transforming under diffeomorphisms of @f{M}
as a square-root of volume element. There is a canonical second order differential operator
@f{\Delta_{\rm can}} acting on densities @cite{Khudaverdian:1999}.
@bystro-margin-note{@f{\Delta_{\rm can}}}
A half-density @f{\rho_{1/2}} is said to satisfy the Quantum Master Equation (QME) if:
@e{
   \Delta_{\rm can} \rho_{1/2} = 0
   }
A small deformation of @f{\rho_{1/2}} can be described by a function @f{f} on @f{M}:
@e{
   \delta \rho_{1/2} = f\rho_{1/2}
   }
If @f{\rho_{1/2}} satisfies QME, the deformation satisfies QME iff:
@(align
  r.l.n
  `("" @,f{\Delta_{\rho_{1/2}} f = 0} "")
  )
where:
@e[#:label "DeltaFromRho"]{
   \Delta_{\rho_{1/2}} f = {1\over \rho_{1/2}}\Delta_{\rm can}(f\rho_{1/2})
   }
The operator @f{\Delta_{\rho_{1/2}}} acts on functions. It does depend on @f{\rho_{1/2}},
but its @bold{leading symbol} does not depend on @f{\rho_{1/2}}. In other words, if @f{\rho_{1/2}^{(1)}}
and @f{\rho_{1/2}^{(2)}} are two half-densities, then @f{\Delta_{\rho_{1/2}^{(1)}} - \Delta_{\rho_{1/2}^{(2)}}}
is a first order differential operator.


In Darboux coordinates (see Eq. (@ref{DarbouxCoordinates})):
@e{
   \Delta_{\rho_{1/2}} = \sum_A (-1)^{\bar{A} + 1}{\partial\over\partial\phi_A^{\star}}{\partial\over\partial\phi^A} + \ldots
   }
In physics notations:
@(align
  r.l.n
  `(@,f{\Delta_{\rho_{1/2}} \;=\;} @,f{\Delta^{(0)} + \{S_{\rm BV},\_\}} "")
  `(@,elem[#:style 'no-break]{where@hspace[2]}
          @,f{\Delta^{(0)} = \sum_A (-1)^{\bar{A} + 1}{\partial\over\partial\phi_A^{\star}}{\partial\over\partial\phi^A}}
          "")
  )

@subpage[1 "Deformation complex" #:tag "sec:DeformationComplex"]

The cohomology of @f{\Delta_{\rho_{1/2}}} corresponds to @bold{deformations} of @f{\rho_{1/2}} preserving the QME, modulo
trivial deformations.
(Trivial deformations are those which can be undone with infinitesimal canonical transformations.)

Eq. (@ref{DeltaFromRho}) associates to every half-density @f{\rho_{1/2}} a nilpotent second order
differential operator with the leading symbol @f{\Delta^{(0)}}, which is determined by the odd Poisson structure.
(The leading symbol @bold{is} the odd Poisson structure.)
In fact, this correspondence is one-to-one up to multiplicative constant.
For each nilpotent second order differential operator with leading symbol @f{\Delta^{(0)}} exists a half-density
@f{\rho_{1/2}} such that this operator is @f{\Delta_{\rho_{1/2}}}.

Therefore there is one-to-one correspondence between deformation complexes and half-densities.
In some situations, we can ``forget'' about @f{\Delta^{(0)}}. Then, the differential of the deformation complex
is @f{d = \{S_{\rm BV},\_\}}, and the half-density is @f{e^{S_{\rm BV}}}.
If a first order differential operator @f{X} preserves the odd Poisson bracket, then we can find
the corresponding BV Hamiltonian @f{\underline{X}} such that @f{X = \{\underline{X},\_\}}.
Then the correspondence is:
@e[#:label "ExpD"]{
   d \mapsto e^{\underline{d}}
   }
The correspondence between deformation complex and half-density
is ``exponentiation of the BV Hamiltonian of differential''.

This is only true roughly speaking, because actually @f{X} is a @bold{second} order differential operator
(not a vector field) and @f{\rho}
is a half-density (not a function). However, locally, in Darboux coordinates, we can indeed say:
@e{
   \Delta^{(0)} + \{S_{\rm BV},\_\} \;\leftrightarrow\; e^{S_{\rm BV}}
   }
We will use this ``physics'' notations throughout this paper, remembering that this @f{e^{S_{\rm BV}}} is a half-density.

Half-densities (just as functions) can be pulled-back by diffeomorphisms.
In case of a function @f{f} and a diffeomorphism @f{g}, the pull-back is a composition, therefore it is natural
to denote it @f{f\circ g}. We will use the same notation for the pull-back of a half-density:
@e{
   e^{S_{\rm BV}}\circ g
   }
If @f{e^{S_{\rm BV}}} satisfies QME, and @f{g} is a canonical transformation deformable to the identity transformation, then:
@e{
   e^{S_{\rm BV}}\circ g = e^{S_{\rm BV}} + \Delta_{\rm can}(\ldots)
   }


@page[@elem{DGLA @f{Dg} (now @f{D\mathfrak{h}}) and equivariant BV} #:tag "EquivariantBV" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 "Cone and Weil algebra" #:tag "sec:ConeAndWeil"]

Let @f{\mathfrak h} be a Lie superalgebra, @f{C{\mathfrak h}} be the cone of @f{\mathfrak h}, and @f{W_{\mathfrak h}} be the Weil algebra of @f{\mathfrak{h}}.
(See @italic{e.g.} @cite{Meinrenken} for the definitions and general .)
The cone @f{C\mathfrak h} is generated by @f{{\cal L}\langle x \rangle} and @f{\iota\langle x\rangle} where @f{x\in \mathfrak{h}}. We use angular brackets @f{\langle\ldots\rangle} instead of the usual @f{(\ldots)} to emphasize linear dependence of a function on its argument. 
The generators of @f{W_{\mathfrak{h}}} will be denoted @f{{\bf\theta}^a} and @f{{\bf t}^a}, and its differential will
be denoted @f{d_W}:
@(align
  r.l.n
  `(@,f{d_W{\bf \theta}^a =}
       @,f{{\bf t}^a - {1\over 2} f^a_{bc} {\bf \theta}^b{\bf \theta}^c}
       "")
  `(@,f{d_W{\bf t}^a =}
       @,f{f^a_{bc}{\bf\theta}^b{\bf t}^c}
       "")
  )
The action of @f{C\mathfrak{h}} on @f{W_{\mathfrak{h}}} is such that @f{\iota\langle x\rangle}
acts as @f{x^a{\partial\over\partial{\bf \theta}^a}}.

@subpage[1 @elem{Definition of @f{D\mathfrak h}} #:tag "sec:DefDg"]

We use the DGLA  @f{D\mathfrak h} as it was defined in @cite{Alekseev:2010gr}.
It is generated by @f{l_a} and @f{i_{a_1\ldots a_n}} where @f{n\in\{1,2,\ldots\}}.
The @f{l_a} generate @f{\mathfrak{h}}.
The @f{i_{a_1\ldots a_n}} are symmetric in @f{a_1,\ldots,a_n};
they generate a free Lie superalgebra.
We denote:
@e{
   i_n\langle x\otimes\cdots\otimes x\rangle = i_{a_1\ldots a_n} x^{a_1}\cdots x^{a_n}\;,\;
   i(x) = \sum_n i\langle x^{\otimes n}\rangle
   }
The differential acts as follows:
@(align
  r.l.n
  `(""
    @,f{d_{D\mathfrak{h}} l\langle x\rangle = 0}
    "")
  `(""
    @,f{d_{D\mathfrak{h}} i(x) = l\langle x\rangle + {1\over 2}[i(x),i(x)]}
    "")
  )
The characteristic property of the construction @f{\mathfrak{h} \mapsto D\mathfrak{h}} is:
@(itemlist
  @item{For any linear space @f{V},
            to define an action of @f{C{\mathfrak h}} on @f{W_{\mathfrak h}\otimes V} 
            is the same as to define the action of @f{D{\mathfrak h}} on @f{V}.}
  )
More precisely, we must assume that @f{\iota\langle x\rangle} acts on @f{W_{\mathfrak{h}}\otimes V}
as @f{x^a{\partial\over\partial{\bf\theta}^a}} and @f{{\cal L}\langle x\rangle} acts as
@f{f^a_{bc}x^b\left({\bf\theta}^c{\partial\over\partial{\bf\theta}^a} + {\bf t}^c{\partial\over\partial{\bf t}^a}\right) + x^ar_V\langle l_a\rangle} where @f{r_V\langle l_a\rangle} are some action of @f{\mathfrak{h}} on @f{V}.
The most nontrivial part of the construction is to define the action of @f{d_{C\mathfrak{h}}} on @f{W_{\mathfrak{h}}\otimes V},
which would be compatible with @f{[\iota\langle x\rangle, d_{C\mathfrak{h}}] = {\cal L}\langle x\rangle}. This is where @f{i(x)} enters, Eq. (@ref{EntersI}):
@(align
  r.l.n
  `(@,f{r_{W_{\mathfrak h}\otimes V}\langle \iota\langle x\rangle\rangle\;=\;}
       @,f{x^a{\partial\over\partial{\bf\theta}^a}}
       "")
  `(@,f{r_{W_{\mathfrak h}\otimes V}\langle {\cal L}\langle x\rangle\rangle\;=\;}
       @,f{f^a_{bc}x^b\left({\bf\theta}^c{\partial\over\partial{\bf\theta}^a} + {\bf t}^c{\partial\over\partial{\bf t}^a}\right) + x^ar_V\langle l_a\rangle}
       "")
  `(@,f{r_{W_{\mathfrak h}\otimes V}\langle d_{C\mathfrak{h}}\rangle\;=\;}
       @,f{d_{W\mathfrak{h}} + r_V\langle d_{C\mathfrak{h}}\rangle + r_V\langle l\langle{\bf \theta}\rangle\rangle
             - r_V\langle i({\bf t})\rangle}
       @,label{EntersI})
  )

@subpage[1 @elem{Action of @f{D\mathfrak{h}} on BV phase space} #:tag "sec:DgOnBV"] 

Let us take @f{V = {\mathfrak a}}, where @f{\mathfrak{a}} is the Lie superalgebra of functions on BV phase space @f{M},
and require that:
@(itemlist
  @item{@f{l_a} and @f{i_{a_1\ldots a_n}} act by infinitesimal canonical transformations,
          generated by some BV Hamiltonians @f{\underline{l_a}} and @f{\underline{i_{a_1\ldots a_n}}}}
  @item{The differential @f{d_{D\mathfrak{h}}} acts as a second order differential operator, with the leading symbol
            defined by the odd Poisson bivector (the leading symbol of the odd Laplace operator)}
  )
Then we use the ``exponentiation method'', Eq. (@ref{ExpD}), to obtain the equivariant half-density, Eq. (@ref{EquivariantRhoInDarboux}).

Eq. (@ref{EntersI}) becomes:
@(align
  r.l.n
  `(@,f{r_{W_{\mathfrak h}\otimes {\mathfrak a}}\langle d_{C\mathfrak h}\rangle \;=\;}
       @,f{d_{W_{\mathfrak h}} + r_{\mathfrak a}\langle d_{D\mathfrak h}\rangle +
             {\bf\theta}^a \{\underline{l_a},\_\} - \sum {\bf t}^{a_1}\cdots {\bf t}^{a_n}
             \{\underline{i_{a_1\ldots a_n}},\_\}}
       @,label{ActionOfDCgOnWa})
  `(@,elem[#:style 'no-break]{where @hspace[2]}
          @,f{r_{\mathfrak a}\langle d_{D\mathfrak h}\rangle = \Delta^{(0)} + \{S_{\rm BV},\_\}}
          "")
  )
The action of @f{\iota\langle x\rangle} for @f{x\in {\mathfrak h}} is:
@(align
  r.l.n
  `(@,f{r_{W_{\mathfrak h}\otimes {\mathfrak a}}\langle\iota\langle x\rangle\rangle \;=\;}
       @,f{x^a{\partial\over\partial {\bf\theta}^a}}
       @,label{ActionOfIotaOnWa})
  )
We must stress that the action of @f{C{\mathfrak h}} on @f{\mathfrak a} is @bold{not defined}.
We only have a representation of @f{D{\mathfrak h}} 
(and the differential @f{d_{D\mathfrak h}}) on @f{\mathfrak a}, and this already allows us to
define (following @cite{Alekseev:2010gr}) the action of @f{C{\mathfrak h}} on @f{W_{\mathfrak h}\otimes {\mathfrak a}}.
In a special case when @f{i_{a_1\ldots a_n}} vanishes for @f{n>1}, we do have the action of @f{C\mathfrak h},
with its differential, on @f{\mathfrak a}. In this case Eqs (@ref{ActionOfDCgOnWa}) and (@ref{ActionOfIotaOnWa})
may be called ``Cartan model of equivariant cohomology of @f{\mathfrak a}''.

@subpage[1 @elem{Action of @f{C\mathfrak{h}} on half-densities} #:tag "sec:ChOnHalfDensities"]

Although we might not have the action of @f{C\mathfrak{h}} on @f{\mathfrak a}, we @bold{do}
have the action of @f{C\mathfrak h} on half-densities @f{\mbox{Dens}_{1/2}(M)}.
Indeed, @f{{\cal L}\langle x\rangle} acts as the Lie derivative along @f{l_a x^a},
and @f{\iota\langle x \rangle} acts as the multiplication by @f{\underline{l_a}x^a}.
The differential of @f{C\mathfrak h} acts as @f{\Delta_{\rm can}}.
Therefore we can consider Weil (or Cartan) model of @f{\mbox{Dens}_{1/2}(M)}.

@subpage[1 "Equivariant half-density" #:tag "sec:EquivariantHalfDensity"]

It turns out that the exponentiation method (see Eq. (@ref{ExpD})) brings 
@f{r_{W_{\mathfrak h}\otimes {\mathfrak a}}\langle d_{C\mathfrak h}\rangle}
to a cocycle of the Weil model @f{W_{\mathfrak h}\otimes \mbox{Dens}_{1/2}(M)}. As in Eq. (@ref{ExpD}),
the @bold{equivariant Master Density} @f{\rho_{1/2}(A,F)}
corresponding to @f{r_{W_{\mathfrak h}\otimes {\mathfrak a}}\langle d_{C\mathfrak h}\rangle}
is defined as the
unique half-density @f{\rho_{1/2}({\bf\theta}, {\bf t})} such that:
@e{
   r_{\mathfrak a}(d_{D\mathfrak h}) +
   {\bf\theta}^a \{\underline{l_a},\_\} - \sum {\bf t}^{a_1}\cdots {\bf t}^{a_n} \{\underline{i_{a_1\ldots a_n}},\_\}
   \;=\;
   \Delta_{\rho_{1/2}({\bf\theta},{\bf t})}
   }
In Darboux coordinates, the correspondence @f{d\leftrightarrow \rho_{1/2}} is,
literally, exponentiation:
@e[#:label "EquivariantRhoInDarboux"
   ]{
     \rho_{1/2}({\bf \theta},{\bf t}) \;=\;
     \exp\left(
               S_{\rm BV} - {\bf \theta}^a \underline{l_a} + \sum {\bf t}^{a_1}\cdots {\bf t}^{a_n} \underline{i_{a_1\ldots a_n}}
               \right)
     }
It satisfies:
@e[#:label "QMEWeil"
   ]{
     (d_{W_{\mathfrak g}} + \Delta_{\rm can})\rho_{1/2}({\bf \theta},{\bf t}) = 0
     }

@subpage[2 @elem{Cartan model and Weil model} #:tag "sec:CartanAndWeil"]

Notice that @f{\rho_{1/2}({\bf \theta},{\bf t})} is basic in the Weil model:
@e[#:label "HorizonthalWeil"
   ]{
     \left({\partial\over\partial{\bf \theta}^a} + \iota\langle l_a\rangle\right)\rho_{1/2}({\bf \theta}, {\bf t}) = 0
     }
(remember that @f{C\mathfrak h} acts on half-densities, @f{\iota\langle x\rangle} acts as multiplication by @f{\underline{x}},
          in this case multiplication by @f{\underline{l_a}}).
This is counter-intuitive, as @f{r_{W_{\mathfrak h}\otimes {\mathfrak a}}\langle d_{C\mathfrak h}\rangle}
(defined in Eq. (@ref{ActionOfDCgOnWa}))
is in the Cartan model. Indeed, an infinitesimal deformation of @f{\rho_{1/2}({\bf \theta}, {\bf t})} is
presented as @f{V({\bf \theta}, {\bf t})\rho_{1/2}({\bf \theta}, {\bf t})} where @f{V({\bf \theta}, {\bf t})}
is a function on @f{M}. Then:
@e[#:label "IotaOnDeformedRho"
   ]{
     \iota_{W_{\mathfrak h}\otimes \mathfrak{a}}\langle l_a\rangle (V\rho_{1/2}) =
     \left({\partial\over\partial{\bf \theta}^a} + \iota\langle l_a\rangle\right)(V\rho_{1/2}) =
     V\left({\partial\over\partial{\bf \theta}^a} + \iota\langle l_a\rangle\right)\rho_{1/2} +
     \left({\partial\over\partial{\bf \theta}^a}V\right)\rho_{1/2}
     }
Therefore @f{\iota_{W_{\mathfrak h}\otimes \mathfrak{a}}\langle l_a\rangle} acts on deformations as in the Cartan model:
@e[#:label "IotaOnDeformation"
   ]{
     \iota_{W_{\mathfrak h}\otimes \mathfrak{a}}\langle l_a\rangle V = {\partial\over\partial{\bf \theta}^a}V
     }
The equivariant half-density in the Cartan model is:
@e[#:label "EquivariantRhoCartan"
   ]{
     \rho^{\tt C}_{1/2}({\bf t}) \;=\;
     \exp\left(
               S_{\rm BV} + \sum {\bf t}^{a_1}\cdots {\bf t}^{a_n} \underline{i_{a_1\ldots a_n}}
               \right)
     }
It satisfies:
@e{
   \Delta_{\rm can}\rho^{\tt C}_{1/2}({\bf t}) = \underline{l\langle {\bf t}\rangle} \rho^{\tt C}_{1/2}({\bf t})
   }

@subpage[1 "Deformation complex" #:tag "sec:EquivariantDeformationComplex"]

Suppose that @f{\rho_{1/2}({\bf \theta}, {\bf t})} satisfies equivariant Master Equation, and is @f{C\mathfrak h}-invariant. 
Let @f{f({\bf \theta}, {\bf t})} be a function on @f{M} depending on @f{\bf \theta} and @f{\bf t}.
A deformation of @f{\rho_{1/2}({\bf \theta}, {\bf t})} of the form:
@e{
   \delta\rho_{1/2}({\bf \theta}, {\bf t}) = f({\bf \theta}, {\bf t})\rho_{1/2}({\bf \theta}, {\bf t})
   }
preserves the equivariant Master Equation iff:
@e[#:label "EquivariantDeformation"
   ]{
     \left(d_W + \Delta + {\bf \theta}^a \{l_a,\_\} - \{i({\bf t}),\_\}\right)f({\bf \theta}, {\bf t}) = 0
     }
where @f{\Delta = \Delta_{\rho_{1/2}(0,0)}}. Moreover, the deformation is trivial if
@f{f} is in the image of @f{d_W + \Delta + {\bf \theta}^a \{l_a,\_\} - \{i({\bf t}),\_\}}.
As we also impose the @f{C\mathfrak h}-invariance on @f{\rho_{1/2}}, we must require:
@(align
  r.l.n
  `("" @,f{{\partial\over\partial{\bf \theta}^a}f({\bf \theta},{\bf t}) = 0} "")
  `(""
    @,f{\left.{d\over dt}\right|_{t=0} f\left({\rm Ad}(e^{t\xi}){\bf t}\right) = \{\underline{\xi}, f\}}
    "")
  )
A horizonthal @f{f({\bf \theta},{\bf t})} does not depend on @f{\bf \theta}. In this case we write @f{f({\bf t})} instead of @f{f({\bf \theta},{\bf t})}.


@page["Integration over families of Lagrangian submanifolds" #:tag "IntegrationOverFamilies" #:showtitle #t]

Let us fix a Lagrangian submanifold @f{L}, and consider all Lagrangian
submanifolds which can be obtained from @f{L} by canonical transformations.
This is an ``infinite-dimensional supermanifold''.
We will call it @f{\rm LAG}:
@(align
  r.l.n
  `(@,f{{\rm LAG}\;=\;}
       @,f{\{gL|g\in G\}}
       "")
  )
Here @f{G} is the group of canonical transformations of @f{M}.

Consider the following pseudo-differential form (PDF) on @f{\rm LAG}:
@e[#:label "Omega"]{
   \Omega = \int_{gL}\exp\left(\underline{dgg^{-1}} + S_{\rm BV}\right)
   }
This is a closed form. This can be seen by rewriting it equivalently as follows:
@e{
   \Omega = \int_L\exp\left(S_{\rm BV}\circ g + \underline{g^{-1}dg}\right)
   }
The @f{\mathfrak{h}}-equivariant analogue of @f{\Omega} is:
@(align
  r.l.n
  `(@,f{\Omega({\bf \theta},{\bf t}) \;=\;}
       @,f{\Omega({\bf \theta},{\bf t}) =
                 \int_{gL}\exp\left(
                                    S_{\rm BV}
                                    +
                                    \underline{dgg^{-1} - l\langle{\bf \theta}\rangle + i({\bf t})}
                                    \right)\;=}
       @,label{EquivariantOmega})
  `(@,f{\;=\;}
       @,f{\int_L\exp\left(S_{\rm BV}\circ g + \underline{g^{-1}dg} - \underline{(l\langle{\bf \theta}\rangle + i({\bf t}))}\circ g\right)}
       "")
  )
The construction of @f{\Omega}, as we now presented it, has the following defect.
We want to define a PDF on @f{\rm LAG}, not on @f{G}. Therefore @f{g} is
only defined up to @f{g\sim gg_0} where @f{g_0L = L}.
Therefore the restriction of @f{\underline{g^{-1}dg}} on @f{L} is only
defined up to a constant. This can be remedied in a number of ways, as
described in @cite{Mikhailov:2016myt},@cite{Mikhailov:2016rkp}. Here we will
assume that there is a ghost number symmetry, and consider only those
Lagrangian submanifolds which are invariant under the ghost number symmetry.
Then @f{\underline{g^{-1}dg}} has ghost number @f{-1}, and cannot be constant.

We will use @f{g} to parametrize @f{\rm LAG}, keeping an eye on @f{g\sim gg_0}.


@page["A BV interpretation of the integration of a differential form" #:tag "IntegrationOfForm" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 @elem{Some lagrangian submanifolds in @f{\Pi T^*\Pi TY}} #:tag "sec:LPiTPiT"]

Let us consider a PDF @f{\alpha} on a supermanifold @f{Y}. Let @f{\underline{d}\in \mbox{Fun}(\Pi T^*(\Pi TY))} be the generating
function of the de Rham differential @f{d} (considered as an odd vector field on @f{\Pi TY}).

For an oriented submanifold @f{X\subset Y}, we can define
@f{\int_X\alpha} as @f{\int_{L_X} e^{\underline{d}}\alpha} where @f{L_X\subset \Pi T^*(\Pi TY)} is the conormal bundle
to @f{\Pi TY|_X \subset \Pi TY}. In local coordinates, @f{L_X} can be described as follows.
We let @f{y\in Y} and its antifield @f{y^{\star}} run in the conormal bundle
of @f{X\subset Y}. At the same time, @f{dy} runs free and @f{(dy)^{\star} = 0}.

To summarize:
@e[#:label "IntegralOfFormInBV"]{
   \int_X\alpha = \int_{L_X} e^{\underline{d}}\alpha
   }

@subpage[1 "Some canonical transformations" #:tag "sec:SomeCanonicalTransformations"] 

Let us consider, in this context, canonical transformations. For any  @f{\beta \in \mbox{Fun}(\Pi TY)},
we can consider @f{\beta} to be a function on @f{\Pi T^* \Pi TY} (as the pullback under the projection) and compute
the Lie derivative of the half-density @f{e^{\underline{d}}\,\alpha} under its Hamiltonian flow:
@e{
   {\cal L}_{\{\beta,\_\}} \left(e^{\underline{d}}\,\alpha\right) \,=\, (-)^{\bar{\beta}}e^{\underline{d}}\,d\beta\;\alpha
   }
(This flow deforms @f{L_X} away from @f{(dy)^{\star}=0}, showing that there is nothing we can get from this construction,
      beyond an integral of a differential form.)
For a vector field @f{v\in\mbox{Vect}(Y)}, let @f{{\cal L}_v} be the Lie derivative (a vector field on @f{\Pi TY}),
and @f{\underline{{\cal L}_v}} its BV Hamiltonian. The Lie derivative of the half-density along @f{\{\underline{{\cal L}_v},\_\}} is:
@e{
   {\cal L}_{\{\underline{{\cal L}_v},\_\}} \left(e^{\underline{d}}\alpha\right)
   =
   - \underline{{\cal L}_v}\Delta_{\rm can}\left(e^{\underline{d}}\alpha\right)
   + \Delta_{\rm can}\left(\underline{{\cal L}_v} e^{\underline{d}}\alpha\right)
   =
   e^{\underline{d}}{\cal L}_v\alpha
   }


@subpage[1 @elem{Universal canonical transformation} #:tag "sec:UniversalCanonicalTransformation"]

Let us consider the extended BV phase space:
@e{
   \widehat{M} = M\times \Pi T^* \Pi T G
   }
where @f{G} is the group of canonical transformations of @f{M} (or perhaps a subgroup of it).
We define the universal canonical transformation @f{\Gamma} as follows:
@e[#:label "UniversalCanonicalTransformation"
   ]{
     (m,\; g,\; dg,\; g^{\star}, (dg)^{\star})
     \stackrel{\Gamma}{\mapsto}
     (gm,\; g,\;  dg,\; g^{\star} + \alpha,\;  (dg)^{\star})
     }
where @f{\alpha} is such that:
@e[#:label "DefAlpha"
   ]{
     dg(g^{\star} + \alpha) = dgg^{\star} + \underline{g^{-1}dg}
     }
(Remember that @f{\underline{\xi}} denotes the BV Hamiltonian of a vector field @f{\xi}.
          The left-invariant form @f{g^{-1}dg} is a map @f{\Pi T G \rightarrow \mbox{Vect}(M)},
          therefore @f{\underline{g^{-1}dg}} is a function on @f{\Pi TG \times M}.)
          
The @f{\Omega} of Eq. (@ref{Omega}) can be interpreted as a half denisty on @f{\widehat{M}}
@e[#:label "OmegaVsGamma"
   ]{
     \exp\left(S_{\rm BV} + \underline{d\;}_{\Pi T^*\Pi TG}\right)\circ \Gamma
     }


@page["Restriction of gauge symmetry to a subgroup" #:tag "RestrictionToH0" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 "General story" #:tag "sec:GeneralStory"]

Consider a manifold @f{X} with an action of the group @f{H}, and a subgroup @f{H_0\subset H}.
The Weil algebra of @f{\mathfrak{h}_0} is the factoralgebra of the Weil algebra of @f{\mathfrak{h}} by a differential ideal:
@e{
   W_{\mathfrak{h}_0} = W_{\mathfrak{h}}/{\cal I}
   }
Let @f{\Omega^{\mathfrak{h}}({\bf\theta},{\bf t})} be an @f{\mathfrak{h}}-equivariantly closed form on @f{X}, and @f{\Omega^{\mathfrak{h}_0}({\bf\theta}_0,{\bf t}_0)} its restriction on @f{\mathfrak{h}_0\subset\mathfrak{h}}:
@e{
   \Omega^{\mathfrak{h}_0} = \Omega^{\mathfrak{h}} \;\mbox{mod}\; {\cal I}\otimes \Omega^{\bullet}(X)
   }
In terms of connections and base forms, suppose that:
@(itemlist
  @item{@f{a_0} is a connection on @f{X\rightarrow H_0\backslash X}, and @f{\Omega_{{\tt base}[a_0]}^{\mathfrak{h}_0}} the corresponding @f{\mathfrak{h}_0}-base form}
  @item{@f{a} is a connection on @f{X\rightarrow H\backslash X}, with
          @f{\Omega_{{\tt base}[a]}^{\mathfrak{h}}} the corresponding @f{\mathfrak{h}}-base form}
  )
Then:
@e[#:label "GeneralRestorationOfH"
   ]{
     \Omega_{{\tt base}[a]}^{\mathfrak{h}} = \Omega_{{\tt base}[a_0]}^{\mathfrak{h}_0} + d(\ldots)
     }
To see this, let us introduce a parameter @f{\tau} and the following family of @f{\mathfrak{h}_0}-connections on
@f{X\times \mathbb{R}_{\tau}} and their curvatures:
@(align
  r.l.n
  `(""
    @,f{\hat{a} = a_0 + \tau(a - a_0)}
    "")
  `(""
    @,f{\hat{f} = d_{X\times \mathbb{R}_{\tau}}\hat{a} + {1\over 2} [\hat{a},\hat{a}]}
    "")
  )
We observe that @f{\hat{a}} and @f{\hat{f}} satisfy the Weil algebra and we can substitute them for
@f{\bf\theta} and @f{\bf t}, obtaining a closed form:
@e{
   d_{X\times\mathbb{R}_{\tau}} \Omega^{\mathfrak{h}}(\hat{a},\hat{f}) = 0
   }
In particular:
@e{
   {\partial\over\partial\tau}\Omega^{\mathfrak{h}}(\hat{a},\hat{f}) =
   d\left({\partial\over\partial d\tau}\Omega^{\mathfrak{h}}(\hat{a},\hat{f})\right)
   }
This implies Eq. (@ref{GeneralRestorationOfH}).

We will now develop this idea in the BV context.

@subpage[1 "Varying the gauge group in BV formalism" #:tag "sec:VaryingGaugeGroupBV"]

Let @f{a_0} be a connection in the @f{H_0}-principal bundle
@f{{\rm LAG}\longrightarrow H_0\backslash {\rm LAG}}:
@(align
  r.l.n
  `("" @,f{a_0\in\Omega^1({\rm LAG},\mathfrak{h}_0)} @,label{TypeOfA0})
  `("" @,f{\iota_{v_{\xi}}a_0 = \xi\quad \forall \xi \in \mathfrak{h}_0} "")
  `("" @,f{{\cal L}_{v_{\xi}}a_0 = [\xi,a_0]\quad \forall\xi\in\mathfrak{h}_0} "")
  )
We will start by using the trick of
〚@seclink["IntegrationOfForm"]{@secref{IntegrationOfForm}}〛 to replace @f{\Omega} with the half-density
on @f{(\Pi T^*\Pi TG)\times M}:
@e[#:label "BigRho"]{
   \rho = \exp\left(
                    S_{\rm BV} - \underline{l\langle a_0\rangle} + \underline{i(f_0)} +
                    \underline{d_G}
                    \right)\circ\Gamma
   }
This defines @f{\rho} as a half-density on @f{(\Pi T^*\Pi T{\rm LAG})\times M}.
But @f{{\rm LAG}} does not have closed cycles. We use a closed cycle in @f{H_0\backslash {\rm LAG}}, not in @f{\rm LAG}.
Therefore, we need a half-density on  @f{(\Pi T^*\Pi T(H_0\backslash {\rm LAG}))\times M}. Indeed, @f{\rho} can be considered
as a half-density on  @f{(\Pi T^*\Pi T(H_0\backslash {\rm LAG}))\times M}, by the BV Hamiltonian reduction. We first put to zero
the BV Hamiltonians generating the action of @f{\Pi TH_0} (a constraint on @f{g^{\star}} and @f{[dg]^{\star}}), and then factor out
by this action. This is possible because @f{\rho} is  @f{H_0}-base as a PDF on @f{\rm LAG}.

Let us introduce an extra parameter @f{\tau\in \mathbb{R}} and denote:
@(align
  r.l.n
  `(@,f{a'(\tau)\;=\;}
       @,f{a_0 + \tau(a - a_0)}
       "")
  `(@,f{f'(\tau,d\tau)\;=\;} @,f{da' + {1\over 2}[a',a'\,]} "")
  )
where the differential @f{d} in @f{da'} includes @f{d\tau{\partial\over\partial\tau}}.
We will now use the following general construction.
Consider an odd symplectic manifold @f{X} and add a pair of Darboux conjugate 
coordinates @f{\tau} and @f{\tau^{\star}}. We get the new odd symplectic manifold:
@e{
   X\times \Pi T^* \mathbb{R}_{\tau}
   }
For any function @f{{\cal F}\in \mbox{Fun}(X\times \mathbb{R}_{\tau})}, there is the  canonical transformation:
@(align
  r.l.n
  `(""
    @,f{\Phi\;:\;X\times \Pi T^* \mathbb{R}_{\tau}\longrightarrow X\times \Pi T^* \mathbb{R}_{\tau}}
    "")
  `(""
    @,f{\Phi
        \left[\begin{array}{c}
                    \tau \cr \tau^{\star} \cr x
                    \end{array}\right]
        =
        \left[\begin{array}{c}
                    \tau \cr
                    \tau^{\star} + {\cal F}(\tau,x) \cr
                    \gamma_{\tau}(x)
                    \end{array}\right]
        }
    @,label{BigPhi})
  )
where @f{\gamma_{\tau}} is a family of canonical transformations of @f{M}, parameterized by @f{\tau},
defined from the equations:
@(align
  r.l.n
  `(@,f{\underline{\gamma^{-1}_{\tau}{\partial\over\partial\tau}\gamma_{\tau}} \;=\;} @,f{{\cal F}(\tau,\_)} @,label{GammaDot})
  `(@,f{\gamma_{\tau = 0} \;=\;} @,f{\mbox{id}} @,label{InitialConditionOnGamma})
  )
More explicitly:
@e[#:label "ExplicitGamma"
   ]{
     \gamma_{\tau} = P\exp\left(\int_0^{\tau} d\tilde{\tau} \{{\cal F(\tilde{\tau},\_)},\_\}\right)
     }
This construction is a special case of
〚@seclink["sec:UniversalCanonicalTransformation"]{@secref{sec:UniversalCanonicalTransformation}}〛,
namely the restriction from @f{G} to a curve @f{\{\gamma_{\tau}|\tau\in {\bf R}\}\subset G}.

In particular, consider @f{X = (\Pi T^* \Pi TG)\times M} and:
@e{
   {\cal F} = {\partial\over\partial d\tau}\underline{i(f')}
   }
Consider the following ``extended'' half-density
on @f{(\Pi T^* \Pi T(G\times\mathbb{R}_{\tau}))\times M}:
@e{
   \widehat{\rho} = \exp\left(S_{\rm BV} -
                                \underline{l\langle a'\rangle} + \underline{i(f')} +
                                \underline{d_{G\times \mathbb{R}_{\tau}}}
                                \right)\circ\Gamma
   }
It satisfies the QME on @f{\Pi T^* \Pi T(G\times\mathbb{R}_{\tau})\times M}. Since @f{\Phi} is a canonical
transformation, the following half-density
also satisfies the QME:
@e{
   \widetilde{\rho} = \exp\left(S_{\rm BV} -
                                  \underline{l\langle a'\rangle} + \underline{i(f')} +
                                  \underline{d_{G\times \mathbb{R}_{\tau}}}
                                  \right)\circ\Phi^{-1}\circ\Gamma
   }
Moreover, @f{\widetilde{\rho}}, as @f{\rho}, does descend by the BV Hamiltonian reduction to a half-density
in @f{\Pi T^* \Pi T ((H_0\backslash G)\times \mathbb{R}_{\tau})\times M}.
This is because @f{\Phi} is a well-defined canonical transformation of  @f{\Pi T^* \Pi T ((H_0\backslash G)\times \mathbb{R}_{\tau})\times M}. Indeed,  @f{a'(\tau)} is an @f{\mathfrak{h}_0}-connection for all values of @f{\tau}, and therefore
@f{{\cal F}\circ g} is @f{\mathfrak{h}_0}-base as a PDF on @f{G}. Therefore it descends to a PDF on @f{H_0\backslash G}. Moreover, it can be considered
a PDF on @f{H_0\backslash {\rm LAG}}, since @f{a'} and @f{f'} are defined as forms on @f{\rm LAG} (see Eq. (@ref{TypeOfA0})).
                                                                                        
We observe that:
@e{
   d\tau{\partial\over\partial d\tau}\underline{i(f')} + d\tau\tau^{\star} =
   (d\tau\tau^{\star})\circ \Phi
   }
Therefore
@f{\exp\left(S_{\rm BV} -
               \underline{l\langle a'\rangle} + \underline{i(f')} +
               \underline{d_{{G}\times \mathbb{R}_{\tau}}}
               \right)\circ\Phi^{-1}\circ\Gamma}
contains @f{d\tau} and @f{\tau^{\star}} only through the multiplicative factor @f{e^{d\tau\tau^*}}. Then QME implies:
@(align
  r.l.n
  `(""
    @,f{{\partial\over\partial\tau}
        \left[
              \exp\left(S_{\rm BV} -
                          \underline{l\langle a'\rangle} + \underline{i(f')} +
                          \underline{d_{G\times \mathbb{R}_{\tau}}}
                          \right)\circ\Phi^{-1}\circ\Gamma
              \right] = 0}
    ""
    )
  )
Restricting to @f{d\tau = 0} and taking @f{\tau=0} then @f{\tau=1}, this implies:
@e[#:label "FlowWithPhi"
   ]{
     \exp\left(S_{\rm BV} -
                 \underline{l\langle a\rangle} + \underline{i(f)} +
                 \underline{d_G}
                 \right)\circ\gamma_1^{-1}\circ\Gamma
     \;=\;
     \exp\left(S_{\rm BV} -
                 \underline{l\langle a_0\rangle} + \underline{i(f_0)} +
                 \underline{d_G}
                 \right)\circ\Gamma
     }
On the other hand:
@(align
  r.l.n
  `(""
    @,f{\exp\left(S_{\rm BV} -
                    \underline{l\langle a\rangle} + \underline{i(f)} +
                    \underline{d_G}
                    \right)
                 \circ{\partial\over\partial\tau}\gamma_{\tau}^{-1}\circ\Gamma
                 \;=}
    @,label{InsertionOfDerivativeOfPhi}
    )
  `(@,f{\;=\;}
       @,f{\Delta_{\rm can}
                  \left[
                        \left(
                              \exp\left(S_{\rm BV} -
                                          \underline{l\langle a\rangle} + \underline{i(f)} +
                                          \underline{d_G}
                                          \right)
                              \underline{{\partial\over\partial d\tau}i(f')}
                              \right)
                        \circ\gamma_{\tau}^{-1}\circ\Gamma\right]
                  }
       "")
  )
where @f{\Delta_{\rm can}} is the canonical operator on @f{\Pi T^* \Pi T (H_0\backslash G)\times M}.
Therefore @f{\gamma_1^{-1}} can be replaced with @f{\rm id}, in the following sense:
@(align
  r.l.n
  `(""
    @,f{
        \exp\left(S_{\rm BV} -
                    \underline{l\langle a\rangle} + \underline{i(f)} +
                    \underline{d_G}
                    \right)\circ\gamma_1^{-1}\circ\Gamma
        \;=\;}
    "")
  `(@,f{=\;}
       @,f{\exp\left(S_{\rm BV} -
                       \underline{l\langle a\rangle} + \underline{i(f)} +
                       \underline{d_G}
                       \right)\circ\Gamma + \Delta_{\rm can}(\ldots)}
       @,label{Phi0Removed})
  )

@subpage[1 "Unintegrated and integrated vertices" #:tag "sec:UnintegratedAndIntegrated"]

Suppose that @f{V\in\mbox{Fun}(M)} satisfies the following conditions:
@(align
  r.l.n
  `(""
    @,f{\Delta_{\rho_{1/2}(0,0)} V = 0}
    "")
  `(""
    @,f{\{l\langle{\bf t}_0\rangle,V\} = 0 \mbox{ for all } {\bf t}_0\in \mathfrak{h}_0}
    "")
  `(""
    @,f{\{i({\bf t}_0),V\} = 0 \mbox{ for all } {\bf t}_0\in \mathfrak{h}_0}
    "")
  )
Then, the product:
@e{
   V\;\rho_{1/2}({\bf \theta}_0, {\bf t}_0)
   }
satisfies the @f{\mathfrak{h}_0}-equivariant Master Equation.
This may be understood as the first derivative of the measure with the @f{S_{\rm BV}} deformed
to @f{S_{\rm BV} + \epsilon V} w.r.to @f{\epsilon} at @f{\epsilon = 0}.

Eq. (@ref{FlowWithPhi}) implies:
@(align
  r.l.n
  `(""
    @,f{\left[
              (V\circ\gamma_1)
              \exp\left(S_{\rm BV} -
                          \underline{l\langle a\rangle} + \underline{i(f)} +
                          \underline{d_G}
                          \right)
              \right]\circ\gamma_1^{-1}\circ\Gamma\;=\;
             }
    @,label{IntegratedVsUnintegratedDensity})
  `(@,f{\;=\;}
       @,f{\left[
                 V
                 \exp\left(S_{\rm BV} -
                             \underline{l\langle a_0\rangle} + \underline{i(f_0)} +
                             \underline{d_G}
                             \right)
                 \right]\circ\Gamma}
       "")
  )
Similarly to Eq. (@ref{Phi0Removed}):
@(align
  r.l.n
  `(""
    @,f{\left[
              (V\circ\gamma_1)
              \exp\left(S_{\rm BV} -
                          \underline{l\langle a\rangle} + \underline{i(f)} +
                          \underline{d_G}
                          \right)
              \right]
             \circ\gamma_1^{-1}\circ\Gamma
             \;=\;}
    "")
  `(@,f{=\;}
       @,f{\left[
                 (V\circ\gamma_1)
                 \exp\left(S_{\rm BV} -
                             \underline{l\langle a\rangle} + \underline{i(f)} +
                             \underline{d_G}
                             \right)
                 \right]\circ\Gamma + \Delta_{\rm can}(\ldots)
                }
       @,label{Phi0RemovedWithV})
  )
Given an integration cycle @f{C\;\subset\;H_0\backslash {\rm LAG}},
@(align
  r.l.n
  `(""
    @,f{\int_{\mathbb{L}_C\times L}
        \left[
              (V\circ\gamma_1)
              \exp\left(S_{\rm BV} -
                          \underline{l\langle a\rangle} + \underline{i(f)} +
                          \underline{d_G}
                          \right)
              \right]\circ\Gamma\;=\;
             }
    @,label{Integrated})
  `(@,f{\;=\;}
       @,f{\int_{\mathbb{L}_C\times L}
                \left[
                      V
                      \exp\left(S_{\rm BV} -
                                  \underline{l\langle a_0\rangle} + \underline{i(f_0)} +
                                  \underline{d_G}
                                  \right)
                      \right]\circ\Gamma
                }
       @,label{Unintegrated})
  )
where @f{\mathbb{L}_C\subset \Pi T^*\Pi T(H_0\backslash {\rm LAG})} is the Lagrangian
submanifold corresponding to @f{C} by the construction of
〚@seclink["IntegrationOfForm"]{@secref{IntegrationOfForm}}〛.
Going back to the language of differential forms:
@(align
  r.l.n
  `(""
    @,f{\int_C\int_L
        (V\circ\phi\circ g)
        \exp\left(\underline{g^{-1}dg}\right)
        \;\;
        \exp\left(
                  S_{\rm BV} - \underline{l\langle a\rangle} + \underline{i(f)}
                  \right)
        \circ g\;=\;
        }
    @,label{IntegratedPDF})
  `(@,f{\;=\;}
       @,f{\int_C\int_L
           (V\circ g)
           \exp\left(\underline{g^{-1}dg}\right)
           \;\;
           \exp\left(S_{\rm BV} - \underline{l\langle a_0\rangle} + \underline{i(f_0)}\right)
           \circ g
           }
       @,label{UnintegratedPDF})
  `(@,elem[#:style 'no-break]{where@hspace[1]}
          @,f{\phi\in\mbox{Map}\left(\Pi T (H_0\backslash H),G\right)}
          "")
  `(""
    @,f{\phi = P\exp\int_0^1 d\tau {\partial\over\partial d\tau}i(f')}
    "")
  )
The integration cycle @f{C} contains the vertical direction @f{H_0\backslash H}.

In Eq. (@ref{UnintegratedPDF}),
@f{\exp\left(\underline{g^{-1}dg}\right)
            \;\;
            \exp\left(S_{\rm BV} - \underline{l\langle a_0\rangle} + \underline{i(f_0)}\right)
            \circ g}
is @f{\mathfrak{h}_0}-base,
and @f{V\circ g} is the insertion of the @bold{unintegrated} vertex operator. 

In Eq. (@ref{IntegratedPDF}),
@f{\exp\left(\underline{g^{-1}dg}\right)
            \;\;
            \exp\left(
                      S_{\rm BV} - \underline{l\langle a\rangle} + \underline{i(f)}
                      \right) \circ g}
is @f{\mathfrak{h}}-base. All vertical differentials come from @f{\phi} entering as @f{V\circ \phi\circ g}.
The ``vertical'' integration of @f{V\circ \phi} corresponds to the insertion of the @bold{integrated}
vertex operator corresponding to @f{V}. (``Vertical integration'' means integration along @f{H_0\backslash H}.)

@page["Integrated Vertex" #:tag "IntegratedVertex" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 @elem{Local trivialization of @f{{\rm LAG}\longrightarrow H\backslash {\rm LAG}}} #:tag "sec:LocalTrivialization"]

Locally we can choose a section:
@e{
   s\;:\;H\backslash {\rm LAG} \longrightarrow {\rm LAG}
   }
Each @f{g\in H_0\backslash {\rm LAG}} can be written as a product:
@(align
  r.l.n
  `(@,f{g\;=\;} @,f{hs(m)} "")
  `(@,f{h\in} @,f{H_0\backslash H} "")
  `(@,f{m\in} @,f{H\backslash {\rm LAG}} "")
  )
With this local trivialization, the @f{\mathfrak{h}}-connection @f{a} can be written as follows:
@(align
  r.l.n
  `(@,f{a\;=\;} @,f{dh h^{-1} + hAh^{-1}} "")
  `(@,elem[#:style 'no-break]{where@hspace[1]} @,f{A\in \Omega^1(H\backslash{\rm LAG})\otimes \mathfrak{h}} "")
  )

@subpage[1 "Unperturbed measure in terms of local trivialization" #:tag "sec:UnperturbedMeasure"]

Eq. (@ref{EquivariantOmega}) becomes:
@(align
  r.l.n
  `(""
    @,f{\int_L
        e^{\underline{s^{-1}ds}}
        \exp\left(
                  S_{\rm BV} -
                  \underline{l\langle A\rangle}   +
                  \underline{i\left(dA + {1\over 2}[A,A]\right)}
                  \right)\circ s
        }
    "")
  )
Gauge invariance is manifested by the @f{h}-independence of this measure.

@subpage[1 @elem{@f{\gamma_1} in local trivialization} #:tag "sec:Phi1Trivialization"]

@(align
  r.l.n
  `(@,f{\gamma_1\circ g\;=\;}
    @,f{h\circ
        \left(
              P\exp\int_0^1
              d\tau
              {\partial\over\partial d\tau}
              i\Big(
                    d\tau (h^{-1}dh - h^{-1}a_0h + A)+\hat{F}
                    \Big)
              \right)\circ s(m)
        }
    @,label{PhiInTrivialization})
  `(@,elem[#:style 'no-break]{where@hspace[1]}
          @,f{\hat{F} = h^{-1}\Big((1-\tau)f_0 + \tau f + {1\over 2} \tau(1-\tau)[a-a_0,a-a_0]\Big)h\;=}
          "")
  `(""
    @,f{\phantom{\hat{F}} =
        (1-\tau)h^{-1}f_0h +
        \tau \left(dA + {1\over 2}[A,A]\right) \;+}
    "")
  `(""
    @,f{\phantom{\hat{F} =}
                + {1\over 2} \tau(1-\tau) [h^{-1}\nabla^{[a_0]}h + A,h^{-1}\nabla^{[a_0]}h + A]
                }
    "")
  )

@subpage[1 "Local integrated vertex" #:tag "sec:LocalIntegratedVertex"]

Locally on @f{\rm LAG} we can choose connection so that @f{A=0}. Then:
@(align
  r.l.n
  `(""
    @,f{V\circ\gamma_1\circ h \;=\;}
    "")
  `(@,f{\;=\;}
       @,f{\left(
                 P\exp\int_0^1
                 d\tau
                 {\partial\over\partial d\tau}
                 i\Big(
                       d\tau h^{-1}\nabla^{[a_0]}h +
                       (1-\tau)h^{-1}f_0h +
                       {1\over 2}\tau(1-\tau)\left[h^{-1}\nabla^{[a_0]}h,h^{-1}\nabla^{[a_0]}h\right]
                       \Big)
                 \right)(V\circ h)
                }
       @,label{IntegratedVertexInBVLanguage})
  )
This is a PDF in @f{H_0\backslash H}, and has to be integrated over a closed cycle in @f{H_0\backslash H}.
The result is the integrated vertex operator corresponding to @f{V}:
@e{
   U = \int_c V\circ\gamma_1
   }
It satisfies the Master equation:
@e{
   \Delta_{\rm can}\left(Ue^{S_{\rm BV}}\right) = 0
   }
We will now give a direct proof of this. The restriction of @f{\Omega_V^{\mathfrak{h}_0-{\tt base}}} to
@f{H_0\backslash HL\;\subset \;H_0\backslash {\rm LAG}} is:
@e{
   \Omega_V^{\mathfrak{h}_0-{\tt base}}|_{H_0\backslash HL}
   \;=\;
   \int_L
   (V\circ h)
   \exp\left(S_{\rm BV} + \underline{l\langle h^{-1}(dh h^{-1} - a_0)h\rangle  + i(h^{-1}f_0h)}\right)
   }
We know by construction this is a closed form, @italic{i.e.} annihilated by @f{d_{H_0\backslash H}}.
Let us consider the half-density on @f{(\Pi T^*\Pi T (H_0\backslash H))\times M} corresponding
to @f{\Omega_V^{\mathfrak{h}_0-{\tt base}}|_{H_0\backslash HL}} by
the construction of
〚@seclink["IntegrationOfForm"]{@secref{IntegrationOfForm}}〛.
It is equal to:
@(align
  r.l.n
  `(""
    @,f{(V\circ h)
        \exp\left(
                  S_{\rm BV} +
                  \underline{l\langle h^{-1}(dh h^{-1} - a_0)h\rangle  + i(h^{-1}f_0h)} +
                  \underline{d_{H_0\backslash H}}
                  \right)\;=
        }
    "")
  `(@,f{=\;}
       @,f{\left[
                 (V\circ\gamma_1)
                 \exp\left(
                           S_{\rm BV} +
                           \underline{d_{H_0\backslash H}}
                           \right)
                 \right]\circ\gamma_1^{-1}\circ \Gamma
                }
       ""
       )
  )
This satisfies the Master Equation by construction. As @f{\gamma_1} is a canonical transformation,
and @f{\Gamma^{-1}\circ\gamma_1\circ\Gamma} is a canonical transformation,
the following half-density on @f{(\Pi T^*\Pi T (H_0\backslash H))\times M} also satisfies the Master Equation:
@e{
   \left[
         (V\circ\gamma_1)
         \exp\left(
                   S_{\rm BV} +
                   \underline{d_{H_0\backslash H}}
                   \right)
         \right]\circ\Gamma
   }
Then pick a Lagrangian submanifold
@f{\mathbb{L}_c\in \Pi T^*\Pi T (H_0\backslash H)} corresponding to a closed cycle @f{c\subset H_0\backslash H}
and integrate over it, as a half-density on @f{\Pi T^*\Pi T (H_0\backslash H)}.
This is essentially a BV push-forward:
@e{
   (\Pi T^*\Pi T (H_0\backslash H))\times M \longrightarrow M
   }
The result satisfies the Master Equation on @f{M}. 
@comment{
         In a typical application of BV formalism,  @f{\Pi T^*\Pi T(H_0\backslash H)} would be considered
         ``fast degrees of freedom'', which we integrate out. 
         This gives an ``effective action'' on @f{M} given by Eq. (@ref{IntegratedVertexInBVLanguage}).
         This terminology does not seem to be very appropriate in our context.
         Should one visualize the point of insertion running very fast all over the worldsheet?
         }

       


@page[@elem{Deformation of @f{i}} #:tag "DeformationOfI" #:showtitle #t]

@bystro-local-toc[]

@subpage[1 @elem{Direct computation} #:tag "sec:DeltaIDirect"]

Eq. (@ref{PhiInTrivialization}) contains the dependence on @f{F = dA + {1\over 2}[A,A]}.
After the integration over @f{h}, this computes the deformation of @f{i} due to the insertion of @f{F}:
@(align
  r.l.n
  `(@,f{\delta_V i(F)\;=\;}
       @,f{\int_{H_0\backslash H}
                \Big(
                      P\exp\int_0^1
                      d\tau
                      {\partial\over\partial d\tau}
                      i\Big(
                            d\tau h^{-1}\nabla^{[a_0]}h \;+
                            %))
                }
       "")
  `(""
    @,f{\phantom{\int_{H_0\backslash H}
                      \Big(
                            P\exp\int_0^1
                            d\tau
                            {\partial\over\partial d\tau}
                            i\Big(
                            %))
                      }
                + (1-\tau)h^{-1}f_0h +
                {1\over 2}\tau(1-\tau)\left[h^{-1}\nabla^{[a_0]}h,h^{-1}\nabla^{[a_0]}h\right] \;+
                }
    ""
    )
  `(""
    @,f{\phantom{\int_{H_0\backslash H}
                      \Big(
                            P\exp\int_0^1
                            d\tau
                            {\partial\over\partial d\tau}
                            i\Big(
                                  %))
                      }
                + F %((
                       \Big)
                      \Big)(V\circ h)
                }
       @,label{IntegralForDeformationOfI}
       )
  )

@subpage[1 "Computation from the defining equation" #:tag "sec:DeltaIComputationFromEquation"]

We have to find @f{\delta_V i({\bf t})} such that:
@e{
   \{S_{\rm BV},\delta_V i({\bf t})\} + \{i({\bf t}),\delta_V i({\bf t})\}
   + \{U, i({\bf t})\} = 0
   }
Here we will restrict ourselves with the case when @f{\mbox{dim}(H_0\backslash H) = 1}. The integration is one-dimensional,
let @f{u} denote the coordinate on @f{H_0\backslash H}. Then the integrated vertex is:
@e{
   U = \int du \{ i_1\langle A_u \rangle , (V\circ f(u)) \}
   }

Given a @f{{\bf t}\in \mathfrak{h}}
such that @f{{\bf t}\neq 0 \;\mbox{mod}\;\mathfrak{h}_0},
let us define @f{\tilde{A}_u} so that:
@(align
  r.l.n
  `("" @,f{\tilde{A}_u - A_u \in \mathfrak{h}_0} "")
  `("" @,f{\tilde{A}_u \in {\mathbb R}{\bf t}} "")
  )
We can expand @f{i({\bf t})} in powers of @f{\bf t}:
@e{
   i({\bf t})
   = i_1\langle {\bf t}\rangle
   + i_2\langle {\bf t}\otimes {\bf t}\rangle
   + i_3\langle {\bf t}\otimes {\bf t}\otimes {\bf t} \rangle
   + \ldots
   }
We claim that the variation of @f{i} from the insertion of @f{U} equals to:
@e{
   \delta i({\bf t})
   = \int du
   \left\{\;
   i_2\langle {\bf t}\bullet \tilde{A}_u \rangle
   + i_3\langle {\bf t}\bullet {\bf t}\bullet \tilde{A}_u\rangle
   + \ldots
   + i_n\langle {\bf t}^{\bullet (n-1)}\bullet \tilde{A}_u\rangle + \ldots
   \;,\;
   V\circ f
   \right\}
   }
where @f{\bullet} means symmetrized tensor product:
@e{
   v_1\bullet\cdots\bullet v_n =
   {1\over n!} \sum_{\sigma\in S_n} v_{\sigma_1}\otimes \cdots \otimes v_{\sigma_n}
   }
This agrees with Eq. (@ref{PhiInTrivialization}). 

@subpage[1 "Some observations" #:tag "sec:DeltaIObservations"]

The case @f{\mbox{dim}(H_0\backslash H)=1} has the following property.
If @f{i({\bf t})} is a polynomial of degree @f{n}, it will remain a polynomial of degree @f{n}
after the deformation.
Moreover, the highest order term @f{i_n\langle {\bf t}^{\otimes n}\rangle} does not receive correction.

Suppose that @f{i_n = 0} for @f{n>1}, @italic{i.e.} @f{i({\bf t})} is linear in @f{\bf t}.
Then @f{\delta_V i({\bf t})=0}, even when @f{\mbox{dim}(H_0\backslash H)\neq 1}.
This can be seen from Eq. (@ref{PhiInTrivialization}).
The curvatures would all come from the @f{F'} in Eq. (@ref{PhiInTrivialization}),
but they only enter through @f{i_{n\geq 2}}.
At the same time, in this case  @f{\{U,i\langle{\bf t}\rangle\} = 0}, and therefore no need to correct @f{i({\bf t})}.
This observation might have an implication for the pure spinor superstring.
Although the BV formalism for the pure spinor superstring has not been fully developed
(only the @f{i_1} has been constructed, in @cite{Mikhailov:2017mdo}, for the AdS background),
we do have some hints. The @f{i_1} must be related to OPE with the @f{b}-ghost.
The pure spinor @f{b}-ghost (unlike the bosonic string @f{b}-ghost) does receive corrections
when we deform the background @cite{Chandia:2013ima}, @cite{Chandia:2019klv}. This seems to indicate that higher @f{i_n} are  nonzero
in the pure spinor formalism.

@bystro-scrbl-only{
@page["Bibliography" #:tag "Bibliography" #:showtitle #t]
}

@(bibliography)


@; ---------------------------------------------------------------------------------------------------
@(bystro-close-connection bystro-conf)
@disconnect[formula-database]
